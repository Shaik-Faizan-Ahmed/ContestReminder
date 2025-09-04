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
) else (
    echo ❌ Debug APK build failed! Check the error messages above.
)

echo.
echo Press any key to exit...
pause > nul
