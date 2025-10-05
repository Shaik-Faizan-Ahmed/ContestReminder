@echo off
echo ========================================
echo Contest Reminder Debug Build Script
echo ========================================

echo.
echo [1/5] Cleaning previous build artifacts...
call flutter clean

echo.
echo [2/5] Getting dependencies...
call flutter pub get

echo.
echo [3/5] Running code generation for Riverpod...
call flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo [4/5] Analyzing code for potential issues...
call flutter analyze

echo.
echo [5/5] Building Debug APK...
call flutter build apk --debug

echo.
echo ========================================
echo Debug Build Complete!
echo ========================================
echo.
echo The debug APK file should be located at:
echo build\app\outputs\flutter-apk\app-debug.apk
echo.

if exist "build\app\outputs\flutter-apk\app-debug.apk" (
    echo ✅ Debug APK successfully created!
    echo File size: 
    for %%A in ("build\app\outputs\flutter-apk\app-debug.apk") do echo %%~zA bytes
    echo.
    echo You can now install this debug APK on your Android device for testing.
    echo.
    echo ========================================
    echo ALARM TESTING INSTRUCTIONS:
    echo ========================================
    echo 1. Install the APK on your device
    echo 2. Grant "Display over other apps" permission when prompted
    echo 3. Grant notification permissions
    echo 4. Set a test alarm for 1-2 minutes from now
    echo 5. Close the app completely
    echo 6. Wait for the alarm - you should see the alarm screen
    echo.
    echo If the alarm screen doesn't show:
    echo - Check Settings ^> Apps ^> Contest Reminder ^> Special access
    echo - Enable "Display over other apps"
    echo - Check that notifications are enabled
    echo ========================================
) else (
    echo ❌ Debug APK build failed! Check the error messages above.
)

echo.
echo Press any key to exit...
pause > nul
