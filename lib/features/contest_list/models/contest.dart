class Contest {
  final String name;
  final String platform;
  final DateTime startTime;
  final String url;
  final String duration;
  final bool isReminderSet;

  Contest({
    required this.name,
    required this.platform,
    required this.startTime,
    required this.url,
    required this.duration,
    this.isReminderSet = false,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      name: json['event'] as String? ?? 'Unknown Contest',
      platform: json['resource'] as String? ?? 'Unknown Platform',
      startTime: DateTime.parse(json['start'] as String),
      url: json['href'] as String? ?? '',
      duration: _formatDuration(json['duration'] as int? ?? 0),
    );
  }

  static String _formatDuration(int seconds) {
    if (seconds <= 0) return 'Unknown';
    
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Contest copyWith({
    String? name,
    String? platform,
    DateTime? startTime,
    String? url,
    String? duration,
    bool? isReminderSet,
  }) {
    return Contest(
      name: name ?? this.name,
      platform: platform ?? this.platform,
      startTime: startTime ?? this.startTime,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      isReminderSet: isReminderSet ?? this.isReminderSet,
    );
  }

  @override
  String toString() {
    return 'Contest(name: $name, platform: $platform, startTime: $startTime, duration: $duration, isReminderSet: $isReminderSet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contest &&
        other.name == name &&
        other.platform == platform &&
        other.startTime == startTime &&
        other.url == url;
  }

  @override
  int get hashCode {
    return Object.hash(name, platform, startTime, url);
  }
}
