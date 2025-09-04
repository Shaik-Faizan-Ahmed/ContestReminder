# Contest Reminder 🏆

A Flutter mobile application that helps competitive programmers stay informed about upcoming coding contests from various platforms. Get notified 5 minutes before contests start, never miss an important competition again!

## ✨ Features

- **📅 Contest Listings**: Fetches upcoming contests from multiple programming platforms via CLIST API
- **⏰ Smart Reminders**: Set reminders that notify you 5 minutes before contests begin
- **🔄 Real-time Updates**: Pull-to-refresh functionality to get the latest contest information
- **🎯 Clean UI**: Modern Material Design 3 interface with intuitive navigation
- **📱 Cross-platform**: Works on both Android and iOS devices
- **🔗 Quick Access**: Copy contest URLs to clipboard for easy access

## 📱 Screenshots

| Contest List | Contest Details | Notifications |
|--------------|-----------------|---------------|
| *Coming Soon* | *Coming Soon* | *Coming Soon* |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.9.0)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android device or emulator for testing

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/contest-reminder.git
   cd contest-reminder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building Release APK

#### Using the Build Script (Recommended)

**Windows:**
```bash
build_release.bat
```

**Linux/Mac:**
```bash
chmod +x build_release.sh
./build_release.sh
```

#### Manual Build

```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter build apk --release --split-per-abi
```

The APK files will be located in:
- `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` (64-bit ARM)
- `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` (32-bit ARM)
- `build/app/outputs/flutter-apk/app-x86_64-release.apk` (64-bit x86)

## 🏗️ Architecture

The project follows a clean architecture pattern with feature-based organization:

```
lib/
├── features/
│   ├── alarms/
│   │   └── alarm_service.dart
│   └── contest_list/
│       ├── data/
│       │   └── contest_service.dart
│       ├── models/
│       │   └── contest.dart
│       └── presentation/
│           ├── providers/
│           ├── widgets/
│           └── contest_list_screen.dart
└── main.dart
```

### Key Components

- **AlarmService**: Handles local notifications and reminders
- **ContestService**: Fetches contest data from CLIST API
- **Contest Model**: Data structure representing contest information
- **Riverpod Providers**: State management for the application
- **Contest Cards**: UI components for displaying contest information

## 🔧 Configuration

### API Configuration

The app uses the CLIST.by API to fetch contest information. The API key is configured in `contest_service.dart`:

```dart
static const String _apiKey = 'your_api_key_here';
static const String _username = 'your_username_here';
```

### Notification Permissions

The app requires notification permissions which are handled automatically on app startup. For Android 13+, explicit permission requests are made.

## 🧪 Testing

Run the test suite:

```bash
flutter test
```

Run integration tests:

```bash
flutter test integration_test/
```

## 📦 Dependencies

### Core Dependencies
- `flutter`: The Flutter framework
- `flutter_riverpod`: State management solution
- `http`: HTTP client for API requests
- `intl`: Internationalization and date formatting

### Notification Dependencies
- `flutter_local_notifications`: Local notification system
- `flutter_timezone`: Timezone handling
- `timezone`: Timezone data

### Development Dependencies
- `flutter_test`: Testing framework
- `build_runner`: Code generation
- `riverpod_generator`: Riverpod code generation
- `mockito`: Mocking for tests

## 🔄 State Management

This app uses Riverpod for state management with the following providers:

- `contestServiceProvider`: HTTP service for fetching contests
- `alarmServiceProvider`: Notification service
- `contestListProvider`: Main state provider for contest list

## 🚨 Troubleshooting

### Common Issues

1. **Build Runner Issues**
   ```bash
   flutter packages pub run build_runner clean
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

2. **Notification Not Working**
   - Ensure notification permissions are granted
   - Check that exact alarm permissions are enabled (Android 12+)
   - Verify timezone configuration

3. **API Connection Issues**
   - Check internet connectivity
   - Verify API key is valid
   - Ensure CLIST API is accessible

### Debug Mode

Run with debug information:
```bash
flutter run --debug
```

Check logs:
```bash
flutter logs
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter/Dart style guide
- Write tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [CLIST.by](https://clist.by/) for providing the contest API
- Flutter team for the amazing framework
- Riverpod community for excellent state management solution

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/contest-reminder/issues) page
2. Create a new issue with detailed information
3. Contact the development team

---

## 📋 Development Checklist

- [x] Basic project structure
- [x] Contest data fetching from API
- [x] Local notification system
- [x] UI/UX implementation
- [x] State management with Riverpod
- [x] Error handling and user feedback
- [x] Build configuration
- [ ] Unit and integration tests
- [ ] App icons and branding
- [ ] Play Store deployment
- [ ] iOS support

## 🔮 Future Enhancements

- [ ] Contest filtering by platform
- [ ] Favorite contests
- [ ] Multiple reminder times
- [ ] Dark mode support
- [ ] Contest calendar view
- [ ] Custom notification sounds
- [ ] Contest history tracking
- [ ] Social sharing features

**Made with ❤️ for the competitive programming community**
