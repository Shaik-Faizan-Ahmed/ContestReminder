import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class AlarmScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const AlarmScreen({Key? key, required this.alarmSettings}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Ensure screen is awake and visible
    _wakeUpScreen();
    
    // Haptic feedback
    HapticFeedback.heavyImpact();
    
    // Animation controllers
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Animations
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start animations
    _pulseController.repeat(reverse: true);
    _slideController.forward();
    _scaleController.forward();
  }

  void _wakeUpScreen() {
    // Additional haptic feedback to ensure device wakes up
    HapticFeedback.heavyImpact();
    
    // Log that alarm screen is being shown
    print('AlarmScreen: Initializing alarm screen display');
    print('AlarmScreen: Contest - ${widget.alarmSettings.notificationSettings.title}');
    
    // Force screen wake up with vibration
    HapticFeedback.vibrate();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = widget.alarmSettings.notificationSettings.body ?? 'Contest';
    final contestName = widget.alarmSettings.notificationSettings.title ?? 'Contest Starting Soon!';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E3A8A), // Deep blue
              const Color(0xFF3B82F6), // Blue
              const Color(0xFF6366F1), // Indigo
              const Color(0xFF8B5CF6), // Purple
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAlarmIcon(),
                          const SizedBox(height: 40),
                          _buildTitle(contestName),
                          const SizedBox(height: 16),
                          _buildSubtitle(platform),
                          const SizedBox(height: 60),
                          _buildActionButtons(context),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlarmIcon() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.alarm_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String contestName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        contestName,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSubtitle(String platform) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getPlatformIcon(platform),
          const SizedBox(width: 8),
          Text(
            _getPlatformDisplayName(platform),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          onPressed: () async {
            HapticFeedback.mediumImpact();
            await Alarm.stop(widget.alarmSettings.id);
            Navigator.pop(context);
          },
          icon: Icons.close_rounded,
          label: 'Dismiss',
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        const SizedBox(width: 32),
        _buildActionButton(
          onPressed: () async {
            HapticFeedback.mediumImpact();
            final url = widget.alarmSettings.payload;
            if (url != null && await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            }
            await Alarm.stop(widget.alarmSettings.id);
            Navigator.pop(context);
          },
          icon: Icons.launch_rounded,
          label: 'Open Contest',
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(28),
              elevation: 0,
            ),
            child: Icon(icon, size: 36),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Contest is starting now! Don\'t miss it!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'leetcode.com':
        return const Icon(Icons.code_rounded, size: 16, color: Colors.white);
      case 'codechef.com':
        return const Icon(Icons.restaurant_rounded, size: 16, color: Colors.white);
      case 'codeforces.com':
        return const Icon(Icons.bolt_rounded, size: 16, color: Colors.white);
      case 'hackerrank.com':
        return const Icon(Icons.military_tech_rounded, size: 16, color: Colors.white);
      default:
        return const Icon(Icons.computer_rounded, size: 16, color: Colors.white);
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