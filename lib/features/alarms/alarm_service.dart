import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart'; // For Platform.isIOS

class AlarmService {
  Future<void> init() async {
    await Alarm.init();
  }

  Future<void> scheduleAlarm(
      int id, DateTime scheduledTime, String contestName, int reminderMinutes, String contestUrl) async {
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: scheduledTime.subtract(Duration(minutes: reminderMinutes)),
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      
      notificationSettings: NotificationSettings(
        title: contestName,
        body: 'Starts in $reminderMinutes minutes!',
        stopButton: 'Stop Alarm',
        icon: 'ic_launcher',
      ),
      androidFullScreenIntent: true, // This is crucial for showing over lock screen
      volumeSettings: VolumeSettings.fixed(),
      payload: contestUrl,
    );

    print('Scheduling alarm with ID: $id for ${scheduledTime.subtract(Duration(minutes: reminderMinutes))}');
    await Alarm.set(alarmSettings: alarmSettings);
    print('Alarm scheduled successfully');
  }

  Future<void> cancelAlarm(int id) async {
    await Alarm.stop(id);
  }
}
