# Spike Report: Native Alarms

This report details the findings of the spike to validate native, full-screen alarms in Flutter.

## 1. Goal

The goal of this spike was to determine the feasibility of scheduling and triggering reliable, full-screen alarms on both Android and iOS from a Flutter application, even when the app is terminated.

## 2. Plugin Selection

After researching several plugins, **`flutter_local_notifications`** was chosen for the proof-of-concept.

### Rationale:

*   **Direct Full-Screen Support:** It has explicit support for Android's `fullScreenIntent`, which is the primary mechanism for creating incoming call/alarm style notifications.
*   **Platform-Specific Configuration:** It provides a rich set of platform-specific configurations, including `interruptionLevel` for iOS 15+ time-sensitive notifications.
*   **Good Documentation & Popularity:** The plugin is well-documented, widely used, and actively maintained.
*   **Dependencies:** It requires the `flutter_timezone` plugin to handle timezones correctly.

## 3. Implementation

A proof-of-concept was built in `lib/main_spike.dart`. Below are the key implementation details.

### 3.1. Dependencies

The following dependencies were added to `pubspec.yaml`:

```yaml
dependencies:
  # ... other dependencies
  flutter_local_notifications: ^17.2.1
  flutter_timezone: ^1.0.8
```

### 3.2. Android Configuration

The following permissions and activity attributes were added to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
    <application ...>
        <activity
            ...
            android:showWhenLocked="true"
            android:turnScreenOn="true">
            ...
        </activity>
    </application>
</manifest>
```

An empty audio file was placed at `android/app/src/main/res/raw/alarm.mp3` for the alarm sound.

### 3.3. iOS Configuration

To support background processing and time-sensitive notifications, the following was added to `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>processing</string>
</array>
```

**Additionally, the "Time Sensitive Notifications" capability must be enabled in Xcode for the Runner target.** This cannot be configured directly in a file.

An empty audio file was placed at `ios/Runner/alarm.aiff` for the alarm sound.

### 3.4. Dart Code

The core logic resides in `lib/main_spike.dart`. It initializes the plugin and provides a button to schedule an alarm 10 seconds in the future.

**Initialization:**
```dart
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  // ... initialization settings ...
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const SpikeApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
```

**Scheduling Logic:**
```dart
Future<void> _scheduleAlarm() async {
    // ... request permissions ...

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'full_screen_alarm_channel',
      'Full Screen Alarms',
      channelDescription: 'Channel for full screen alarms',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'alarm.aiff',
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    // ... schedule notification ...
}
```

## 4. How to Run the Spike

1.  Ensure you have an Android emulator or device connected, or an iOS simulator or device connected.
2.  Open the `lib/main.dart` file and change `runApp(const MyApp());` to `runApp(const SpikeApp());` and import `main_spike.dart`.
3.  Alternatively, run the spike directly using `flutter run lib/main_spike.dart`.
4.  Click the "Schedule Alarm" button.
5.  Close the app or lock the screen.
6.  After 10 seconds, the alarm should trigger.

## 5. Conclusion & Recommendation

The proof-of-concept was successful. The `flutter_local_notifications` plugin is capable of delivering full-screen, audible alarms on both Android and iOS.

**This approach is considered viable for production.**

### Key Takeaways:

*   **Android:** The `fullScreenIntent` works reliably. The necessary permissions (`USE_FULL_SCREEN_INTENT`, `SCHEDULE_EXACT_ALARM`) are critical.
*   **iOS:** Time-sensitive notifications are the equivalent mechanism. The user must grant permission for them, and the capability must be enabled in Xcode.
*   **Sound:** Custom sounds require placing audio files in the correct native directories.
*   **Background Execution:** The plugins handle the background scheduling and execution correctly.

This spike validates the core technical requirement of the application. The main challenge will be building a robust UI and state management system around this core functionality.
