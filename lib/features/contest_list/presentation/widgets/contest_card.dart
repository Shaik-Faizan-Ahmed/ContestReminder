import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contest_reminder/features/contest_list/models/contest.dart';
import 'package:intl/intl.dart';

class ContestCard extends ConsumerStatefulWidget {
  final Contest contest;

  const ContestCard({super.key, required this.contest});

  @override
  ConsumerState<ContestCard> createState() => _ContestCardState();
}

class _ContestCardState extends ConsumerState<ContestCard> with TickerProviderStateMixin {
  late Timer _timer;
  late Duration _timeUntilStart;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _timeUntilStart = widget.contest.startTime.difference(DateTime.now());
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.contest.isReminderSet) {
      _pulseController.repeat(reverse: true);
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timeUntilStart = widget.contest.startTime.difference(DateTime.now());
          if (_timeUntilStart.isNegative) {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isStarted = widget.contest.startTime.isBefore(DateTime.now());
    final isStartingSoon = !isStarted && _timeUntilStart.inMinutes < 30;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // Add tap functionality if needed
      },
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 0.98 : 1.0),
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            gradient: _buildCardGradient(),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _getPlatformColor(widget.contest.platform).withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getPlatformColor(widget.contest.platform).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, isStarted, isStartingSoon),
                  const SizedBox(height: 16),
                  _buildPlatformBadge(context),
                  const SizedBox(height: 16),
                  _buildTimeInfo(context),
                  const SizedBox(height: 16),
                  _buildCountdownSection(context, isStarted, isStartingSoon),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isStarted, bool isStartingSoon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contest.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isStartingSoon && !isStarted) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        size: 12,
                        color: Colors.orange[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Starting Soon',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 16),
        if (widget.contest.isReminderSet)
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildPlatformBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getPlatformColor(widget.contest.platform).withOpacity(0.8),
            _getPlatformColor(widget.contest.platform),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getPlatformColor(widget.contest.platform).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getPlatformIcon(widget.contest.platform),
          const SizedBox(width: 6),
          Text(
            _getPlatformDisplayName(widget.contest.platform),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  DateFormat('MMM dd, yyyy • HH:mm').format(widget.contest.startTime),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.timer_rounded,
                size: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Duration: ${widget.contest.duration}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownSection(BuildContext context, bool isStarted, bool isStartingSoon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isStarted
              ? [Colors.red.withOpacity(0.1), Colors.red.withOpacity(0.05)]
              : isStartingSoon
                  ? [Colors.orange.withOpacity(0.1), Colors.orange.withOpacity(0.05)]
                  : [Theme.of(context).colorScheme.primary.withOpacity(0.1), 
                     Theme.of(context).colorScheme.secondary.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isStarted ? Icons.play_circle_filled_rounded : Icons.access_time_rounded,
            color: isStarted
                ? Colors.red
                : isStartingSoon
                    ? Colors.orange
                    : Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            isStarted ? "Contest Started!" : _formatTimeUntilStart(_timeUntilStart),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isStarted
                  ? Colors.red
                  : isStartingSoon
                      ? Colors.orange[700]
                      : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _buildCardGradient() {
    final platformColor = _getPlatformColor(widget.contest.platform);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        platformColor.withOpacity(0.1),
        platformColor.withOpacity(0.05),
      ],
    );
  }

  Color _getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'leetcode.com':
        return const Color(0xFFFF8C00);
      case 'codechef.com':
        return const Color(0xFF8B4513);
      case 'codeforces.com':
        return const Color(0xFF1E88E5);
      case 'hackerrank.com':
        return const Color(0xFF00B894);
      default:
        return const Color(0xFF6366F1);
    }
  }

  Widget _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'leetcode.com':
        return const Icon(Icons.code_rounded, size: 14, color: Colors.white);
      case 'codechef.com':
        return const Icon(Icons.restaurant_rounded, size: 14, color: Colors.white);
      case 'codeforces.com':
        return const Icon(Icons.bolt_rounded, size: 14, color: Colors.white);
      case 'hackerrank.com':
        return const Icon(Icons.military_tech_rounded, size: 14, color: Colors.white);
      default:
        return const Icon(Icons.computer_rounded, size: 14, color: Colors.white);
    }
  }

  String _getPlatformDisplayName(String platform) {
    switch (platform.toLowerCase()) {
      case 'leetcode.com':
        return 'LeetCode';
      case 'codechef.com':
        return 'CodeChef';
      case 'codeforces.com':
        return 'Codeforces';
      case 'hackerrank.com':
        return 'HackerRank';
      default:
        return platform;
    }
  }
}

String _formatTimeUntilStart(Duration duration) {
  if (duration.inSeconds <= 0) {
    return "Started";
  }

  final days = duration.inDays;
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (days > 0) {
    return "${days}d ${hours}h";
  } else if (days == 0 && hours > 0) {
    return "${hours}h ${minutes}m ${seconds}s";
  } else {
    return "${minutes}m ${seconds}s";
  }
}