import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart'; // For Platform.isIOS

class AlarmService {
  Future<void> init() async {
    await Alarm.init();
  }

  Future<void> scheduleAlarm(
      int id, DateTime scheduledTime, String contestName, int reminderMinutes) async {
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: scheduledTime.subtract(Duration(minutes: reminderMinutes)),
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      
      notificationSettings: NotificationSettings(
        title: contestName,
        body: 'Starts in $reminderMinutes minutes!',
      ),
      androidFullScreenIntent: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  Future<void> cancelAlarm(int id) async {
    await Alarm.stop(id);
  }
}
