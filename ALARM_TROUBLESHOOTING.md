# Alarm Screen Troubleshooting Guide

## Issue: Alarm sound plays but screen doesn't show when app is closed

### Root Cause
The app needs special permissions to display UI over other apps and when the device is locked.

### ✅ FIXES APPLIED:

#### 1. **Permission Handling Improvements** (`main.dart`)
- Added comprehensive permission requests for:
  - System Alert Window (Display over other apps)
  - Notification permissions
  - Exact alarm scheduling
- Added permission status logging for debugging
- Added user-friendly dialogs explaining why permissions are needed

#### 2. **Android Manifest Updates** (`AndroidManifest.xml`)
- Added missing permissions:
  ```xml
  <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
  <uses-permission android:name="android.permission.DISABLE_KEYGUARD" />
  <uses-permission android:name="android.permission.SHOW_WHEN_LOCKED" />
  ```
- Updated MainActivity configuration for better lock screen handling

#### 3. **Alarm Service Enhancements** (`alarm_service.dart`)
- Improved alarm settings with better notification configuration
- Added debugging logs to track alarm scheduling
- Enabled `enableNotificationOnKill` for better reliability

#### 4. **Navigation Improvements** (`main.dart`)
- Changed from `push` to `pushAndRemoveUntil` for better alarm screen display
- Added debugging logs to track navigation state
- Improved error handling when navigator is not available

#### 5. **AlarmScreen Enhancements** (`alarm_screen.dart`)
- Added screen wake-up functionality
- Enhanced haptic feedback to ensure device wakes up
- Added debugging logs for alarm screen initialization

### 🧪 TESTING STEPS:

1. **Build and Install:**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk --debug
   ```

2. **Permission Setup:**
   - Install the APK
   - When prompted, grant "Display over other apps" permission
   - Grant notification permissions
   - If not prompted automatically:
     - Go to Settings > Apps > Contest Reminder > Special access
     - Enable "Display over other apps"

3. **Test Alarm:**
   - Set a test alarm for 1-2 minutes from now
   - Close the app completely (swipe away from recent apps)
   - Wait for the alarm to trigger
   - You should now see the full alarm screen, not just hear sound

### 🔍 DEBUGGING:

If the alarm screen still doesn't show, check the logs:
- Look for permission status messages
- Check "Alarm triggered" messages
- Verify navigation state logs

### ⚠️ IMPORTANT NOTES:

- **System Alert Window permission** is the most critical - without it, the alarm screen cannot show over other apps
- Some Android versions/manufacturers have additional battery optimization settings that may interfere
- The permission might need to be granted manually in device settings if the automatic request fails

### 🏗️ CODE CHANGES SUMMARY:

1. **main.dart**: Improved permission handling and navigation
2. **AndroidManifest.xml**: Added critical permissions
3. **alarm_service.dart**: Enhanced alarm configuration
4. **alarm_screen.dart**: Added wake-up functionality
5. **permission_handler.dart**: New utility for permission management

The main issue was that Android requires explicit "Display over other apps" permission to show UI when the app is not in the foreground. This permission must be granted by the user and cannot be automatically granted like regular permissions.
