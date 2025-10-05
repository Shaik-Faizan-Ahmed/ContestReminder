# Contest Reminder 🏆

A powerful Flutter mobile application that helps competitive programmers stay informed about upcoming coding contests from multiple platforms. Never miss an important competition with smart alarms and real-time notifications!

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

- **📅 Multi-Platform Contest Tracking**: Fetches contests from CodeForces, LeetCode, CodeChef, HackerRank, and 100+ platforms via CLIST API
- **⏰ Full-Screen Alarms**: Set custom alarms with full-screen notifications that work even when the app is closed
- **⏱️ Live Countdown Timers**: Real-time countdown for upcoming contests
- **🎯 Status Indicators**: Color-coded badges showing Running/Upcoming/Finished status
- **🔄 Pull-to-Refresh**: Get the latest contest information instantly
- **🎨 Modern UI**: Clean Material Design 3 interface with professional color scheme
- **🔗 Quick Access**: Direct links to contest pages with one tap
- **📱 Platform Icons**: Visual identification for different coding platforms
- **💾 Offline Support**: Cached contest data for offline viewing
- **🔔 Smart Permissions**: Automatic permission handling for notifications and alarms

## 📱 Screenshots

| Contest List | Alarm Screen | Notifications |
|--------------|--------------|---------------|
| *Coming Soon* | *Coming Soon* | *Coming Soon* |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0 <4.0.0)
- Dart SDK (>=3.0.0 <4.0.0)
- Android Studio or VS Code with Flutter extensions
- Android device or emulator (API level 21+)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Shaik-Faizan-Ahmed/ContestReminder.git
   cd ContestReminder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (for Riverpod providers)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

**Debug APK:**
```bash
flutter build apk --debug
```

**Release APK:**
```bash
flutter build apk --release
```

**Or use the provided batch script (Windows):**
```bash
build_debug_apk.bat
```

The APK will be located at:
- Debug: `build/app/outputs/flutter-apk/app-debug.apk`
- Release: `build/app/outputs/flutter-apk/app-release.apk`

## 🏗️ Architecture

The project follows **Clean Architecture** principles with feature-based organization:

```
lib/
├── core/
│   └── utils/
│       └── permission_handler.dart    # Centralized permission management
├── features/
│   ├── alarms/
│   │   ├── alarm_service.dart         # Alarm scheduling and management
│   │   └── presentation/
│   │       └── alarm_screen.dart      # Full-screen alarm UI
│   └── contest_list/
│       ├── data/
│       │   └── contest_service.dart   # API service for contests
│       ├── models/
│       │   └── contest.dart           # Contest data model
│       └── presentation/
│           ├── contest_list_screen.dart
│           ├── providers/
│           │   └── contest_providers.dart  # Riverpod state management
│           └── widgets/
│               ├── contest_card.dart       # Contest card component
│               └── platform_reminders.dart  # Platform-specific widgets
└── main.dart                          # App entry point
```

### Key Components

- **AlarmService**: Manages alarm scheduling using the `alarm` package with full-screen notifications
- **ContestService**: Fetches and parses contest data from CLIST API
- **Contest Model**: Immutable data structure representing contest information
- **Riverpod Providers**: Type-safe state management with auto-generated code
- **PermissionHandler**: Centralized utility for managing runtime permissions

## 🔧 Technologies Used

### Core Framework
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language

### State Management
- **Riverpod**: Modern, compile-safe state management
- **Riverpod Annotation & Generator**: Code generation for providers

### Networking & Data
- **HTTP**: RESTful API calls to CLIST
- **Intl**: Date/time formatting and internationalization

### Notifications & Alarms
- **Alarm**: Reliable alarm scheduling with full-screen support
- **Flutter Local Notifications**: Local notification system
- **Flutter Timezone & Timezone**: Timezone handling for accurate scheduling

### Utilities
- **URL Launcher**: Open contest links in external browser
- **Permission Handler**: Runtime permission management for Android/iOS

### Development & Testing
- **Flutter Lints**: Code quality enforcement
- **Build Runner**: Code generation automation
- **Mockito**: Mocking framework for unit tests
- **Custom Lint**: Custom linting rules

## 📋 Required Permissions

The app requires the following Android permissions:

- **INTERNET**: Fetch contest data from API
- **POST_NOTIFICATIONS**: Display notifications (Android 13+)
- **SCHEDULE_EXACT_ALARM**: Schedule precise alarms (Android 12+)
- **USE_EXACT_ALARM**: Alternative exact alarm permission
- **SYSTEM_ALERT_WINDOW**: Display alarm screen over other apps
- **DISABLE_KEYGUARD**: Show alarm when device is locked
- **WAKE_LOCK**: Keep device awake during alarms
- **VIBRATE**: Haptic feedback for alarms
- **RECEIVE_BOOT_COMPLETED**: Restore alarms after device restart
- **FOREGROUND_SERVICE**: Run alarm service in foreground

All permissions are automatically requested when needed. See [ALARM_TROUBLESHOOTING.md](ALARM_TROUBLESHOOTING.md) for detailed permission setup.

## 📊 API Integration

The app uses the **[CLIST API](https://clist.by/)** to fetch contest information:

- **Endpoint**: `https://clist.by/api/v4/contest/`
- **Features**:
  - Real-time contest data from 100+ platforms
  - Filtering by date, platform, and status
  - Comprehensive contest details (timing, duration, URL)
  - Pagination support for large datasets

## 🧪 Testing

Run unit tests:
```bash
flutter test
```

Run integration tests:
```bash
flutter test integration_test/
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 🚨 Troubleshooting

### Alarm Screen Not Showing

If the alarm sound plays but the screen doesn't appear:

1. Grant "Display over other apps" permission:
   - Settings → Apps → Contest Reminder → Special access → Display over other apps
2. Disable battery optimization:
   - Settings → Battery → Battery optimization → Contest Reminder → Don't optimize
3. See [ALARM_TROUBLESHOOTING.md](ALARM_TROUBLESHOOTING.md) for comprehensive troubleshooting

### Common Issues

**Build errors:**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**Notification not working:**
- Verify notification permissions are granted
- Check that Do Not Disturb mode is off
- Ensure exact alarm permission is enabled (Settings → Apps → Special access)

**API connection issues:**
- Check internet connectivity
- Verify CLIST API status at [clist.by](https://clist.by/)

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow [Flutter style guide](https://dart.dev/guides/language/effective-dart/style)
- Write unit tests for new features
- Update documentation for API changes
- Use `flutter analyze` to check code quality
- Run tests before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Shaik Faizan Ahmed**

- GitHub: [@Shaik-Faizan-Ahmed](https://github.com/Shaik-Faizan-Ahmed)
- Repository: [ContestReminder](https://github.com/Shaik-Faizan-Ahmed/ContestReminder)

## 🙏 Acknowledgments

- [CLIST.by](https://clist.by/) for providing the comprehensive contest API
- Flutter team for the amazing cross-platform framework
- Riverpod community for excellent state management solution
- All competitive programming platforms for organizing contests

## 🗺️ Roadmap

### Planned Features
- [ ] Platform-specific filtering (CodeForces only, LeetCode only, etc.)
- [ ] Favorite/bookmark contests
- [ ] Multiple alarms per contest (1 hour before, 5 min before, etc.)
- [ ] Dark mode / theme customization
- [ ] Calendar integration (Google Calendar, iCal)
- [ ] Contest history and participation tracking
- [ ] Export schedule to various formats
- [ ] User preferences for contest difficulty/duration
- [ ] Social sharing features
- [ ] Widget support for home screen
- [ ] iOS version
- [ ] Web version

### Completed
- [x] Multi-platform contest tracking
- [x] Full-screen alarm system
- [x] Real-time countdown timers
- [x] Status indicators
- [x] Pull-to-refresh
- [x] Modern Material Design 3 UI
- [x] Permission handling
- [x] Offline caching

---

**Made with ❤️ for the competitive programming community**
