@echo off
echo ========================================
echo Contest Reminder App Build Script
echo ========================================

echo.
echo [1/6] Cleaning previous build artifacts...
call flutter clean

echo.
echo [2/6] Getting dependencies...
call flutter pub get

echo.
echo [3/6] Running code generation for Riverpod...
call flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo [4/6] Analyzing code for potential issues...
call flutter analyze

echo.
echo [5/6] Running tests...
call flutter test

echo.
echo [6/6] Building APK (Release mode)...
call flutter build apk --release

echo.
echo ========================================
echo Build Complete!
echo ========================================
echo.
echo The APK file should be located at:
echo build\app\outputs\flutter-apk\app-release.apk
echo.

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo ✅ APK successfully created!
    echo File size: 
    for %%A in ("build\app\outputs\flutter-apk\app-release.apk") do echo %%~zA bytes
    echo.
    echo You can now install this APK on your Android device.
) else (
    echo ❌ APK build failed! Check the error messages above.
)

echo.
echo Press any key to exit...
pause > nul
