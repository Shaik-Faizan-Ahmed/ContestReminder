import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/platform_specifics/ios/enums.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    try {
      await _configureLocalTimeZone();
      
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
          );
          
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );
      
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
          // Handle notification tap - you can add URL launching here if needed
          print('Notification tapped: ${notificationResponse.payload}');
        },
      );
      
      // Request permissions for Android 13+
      await _requestPermissions();
      
    } catch (e) {
      print('Error initializing alarm service: $e');
      rethrow;
    }
  }

  Future<void> _requestPermissions() async {
    final androidImplementation = 
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
      await androidImplementation.requestExactAlarmsPermission();
    }
  }

  Future<void> _configureLocalTimeZone() async {
    try {
      tz.initializeTimeZones();
      final String timeZoneName = await FlutterTimezone.getLocalTimezone() ?? tz.UTC.name;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      print('Error configuring timezone: $e');
      // Fallback to UTC if local timezone fails
      tz.setLocalLocation(tz.UTC);
    }
  }

  Future<void> scheduleAlarm(
      int id, DateTime scheduledTime, String contestName) async {
    try {
      // Schedule for 5 minutes before the contest starts
      final reminderTime = scheduledTime.subtract(const Duration(minutes: 5));
      
      // Don't schedule if the reminder time is in the past
      if (reminderTime.isBefore(DateTime.now())) {
        throw Exception('Cannot set reminder for past events');
      }
      
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'contest_reminder_channel',
        'Contest Reminders',
        channelDescription: 'Notifications for upcoming programming contests',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
        visibility: NotificationVisibility.public,
      );

      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Contest Starting Soon!',
        'Contest "$contestName" starts in 5 minutes!',
        tz.TZDateTime.from(reminderTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: contestName,
      );
      
      print('Alarm scheduled for $reminderTime for contest: $contestName');
    } catch (e) {
      print('Error scheduling alarm: $e');
      rethrow;
    }
  }

  Future<void> cancelAlarm(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
      print('Alarm cancelled for id: $id');
    } catch (e) {
      print('Error cancelling alarm: $e');
      rethrow;
    }
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    } catch (e) {
      print('Error getting pending notifications: $e');
      return [];
    }
  }

  Future<void> cancelAllAlarms() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
      print('All alarms cancelled');
    } catch (e) {
      print('Error cancelling all alarms: $e');
    }
  }
}
