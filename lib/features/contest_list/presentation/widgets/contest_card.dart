import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contest_reminder/features/contest_list/models/contest.dart';
import 'package:contest_reminder/features/contest_list/presentation/providers/contest_providers.dart';
import 'package:intl/intl.dart';

class ContestCard extends ConsumerWidget {
  final Contest contest;

  const ContestCard({super.key, required this.contest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final isStarted = contest.startTime.isBefore(now);
    final timeUntilStart = contest.startTime.difference(now);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contest name
            Text(
              contest.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            
            // Platform
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                contest.platform,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Start time
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM dd, yyyy • HH:mm').format(contest.startTime),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Duration
            Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  'Duration: ${contest.duration}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Time until start or status
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isStarted 
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isStarted ? "Contest has started" : _formatTimeUntilStart(timeUntilStart),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isStarted ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (contest.url.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      // Copy URL to clipboard
                      Clipboard.setData(ClipboardData(text: contest.url));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contest URL copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.link, size: 16),
                    label: const Text('Copy URL'),
                  ),
                const Spacer(),
                
                // Reminder button
                FilledButton.icon(
                  onPressed: isStarted ? null : () async {
                    try {
                      if (contest.isReminderSet) {
                        // Show confirmation dialog
                        final shouldCancel = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Cancellation'),
                            content: Text(
                              'Are you sure you want to cancel the reminder for "${contest.name}"?'
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('No'),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                        
                        if (shouldCancel == true) {
                          await ref
                              .read(contestListProvider.notifier)
                              .cancelReminder(contest);
                          
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reminder cancelled'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        }
                      } else {
                        await ref
                            .read(contestListProvider.notifier)
                            .setReminder(contest);
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reminder set! You\'ll be notified 5 minutes before the contest.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to ${contest.isReminderSet ? 'cancel' : 'set'} reminder: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  icon: Icon(
                    contest.isReminderSet ? Icons.alarm_on : Icons.alarm_add,
                    size: 16,
                  ),
                  label: Text(contest.isReminderSet ? 'Cancel Reminder' : 'Set Reminder'),
                  style: FilledButton.styleFrom(
                    backgroundColor: contest.isReminderSet 
                        ? Colors.orange 
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeUntilStart(Duration duration) {
    if (duration.inSeconds <= 0) {
      return "Started";
    }
    
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    
    if (days > 0) {
      return "Starts in: ${days}d ${hours}h ${minutes}m";
    } else if (hours > 0) {
      return "Starts in: ${hours}h ${minutes}m";
    } else {
      return "Starts in: ${minutes}m";
    }
  }
}
