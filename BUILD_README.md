# Contest Reminder App - Build Instructions

## Overview
Contest Reminder is a Flutter app that helps users track upcoming programming contests and set reminders for them.

## Prerequisites

Before building the app, ensure you have:

1. **Flutter SDK** installed (version 3.0.0 or higher)
2. **Android Studio** with Android SDK
3. **Java Development Kit (JDK)** version 11 or higher
4. **Android device** or emulator for testing

## Quick Build Instructions

### Option 1: Using Build Scripts (Recommended)

1. **Check Environment**:
   ```bash
   check_environment.bat
   ```
   This will verify your Flutter installation and show connected devices.

2. **Build Debug APK** (for testing):
   ```bash
   build_debug_apk.bat
   ```

3. **Build Release APK** (for distribution):
   ```bash
   build_apk.bat
   ```

### Option 2: Manual Build Process

1. **Clean previous builds**:
   ```bash
   flutter clean
   ```

2. **Get dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code** (for Riverpod providers):
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Build APK**:
   ```bash
   # For debug (larger file size, with debugging info)
   flutter build apk --debug
   
   # For release (optimized, smaller size)
   flutter build apk --release
   ```

## APK Location

After successful build, your APK will be located at:
- **Debug**: `build/app/outputs/flutter-apk/app-debug.apk`
- **Release**: `build/app/outputs/flutter-apk/app-release.apk`

## Installing on Android Device

### Method 1: ADB Install
```bash
flutter install
```

### Method 2: Manual Install
1. Copy the APK file to your Android device
2. Enable "Install from Unknown Sources" in your device settings
3. Open the APK file and install

## Troubleshooting

### Common Issues:

1. **"flutter_timezone not found"**
   - Fixed: Using `flutter_timezone_plus` package instead

2. **Build fails with dependency issues**
   - Run: `flutter clean && flutter pub get`

3. **Code generation errors**
   - Run: `flutter packages pub run build_runner clean`
   - Then: `flutter packages pub run build_runner build --delete-conflicting-outputs`

4. **Android SDK issues**
   - Run: `flutter doctor` and follow the suggestions
   - Ensure Android SDK is properly installed

5. **Permission errors during install**
   - Enable "Install from Unknown Sources" on your Android device
   - Try installing via ADB: `adb install app-release.apk`

## App Features

- 📱 **Contest Listing**: View upcoming programming contests from CLIST.by
- ⏰ **Smart Reminders**: Set notifications 5 minutes before contests start
- 🔄 **Auto Refresh**: Pull to refresh contest data
- 📋 **Contest Details**: View platform, duration, and start time
- 🔗 **Quick Access**: Copy contest URLs to clipboard

## API Configuration

The app uses CLIST.by API with the following configuration:
- **Username**: faizi29
- **API Key**: Configured in the app
- **Endpoint**: https://clist.by/api/v4/contest/

## App Permissions

The app requires these Android permissions:
- `INTERNET` - To fetch contest data
- `POST_NOTIFICATIONS` - To show reminder notifications
- `SCHEDULE_EXACT_ALARM` - For precise timing of reminders
- `WAKE_LOCK` - To wake device for notifications
- `VIBRATE` - For notification vibration

## Development Notes

- Built with Flutter 3.x and Dart 3.x
- Uses Riverpod for state management
- Implements clean architecture with feature-based structure
- Uses `flutter_local_notifications` for reminder system
- Material Design 3 UI components

---

## Support

If you encounter any issues during the build process, please check:
1. Flutter doctor output
2. Error messages in the console
3. Android SDK configuration

Happy coding! 🚀
