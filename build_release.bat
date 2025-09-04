@echo off
echo 🏁 Starting Contest Reminder APK Build Process...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    pause
    exit /b 1
)

echo 📋 Flutter Doctor Check...
flutter doctor

echo 🧹 Cleaning previous builds...
flutter clean

echo 🗑️  Removing generated files...
if exist ".dart_tool" rmdir /s /q ".dart_tool"
if exist "build" rmdir /s /q "build"

echo 📦 Getting dependencies...
flutter pub get

echo 🏗️  Running build runner for code generation...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo 🔧 Building release APK with specific target...
flutter build apk --release --target=lib/main.dart --split-per-abi

if %errorlevel% equ 0 (
    echo ✅ APK built successfully!
    echo 📱 APK files are located at:
    echo    - build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
    echo    - build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk  
    echo    - build\app\outputs\flutter-apk\app-x86_64-release.apk
    echo.
    echo 🎉 Contest Reminder is ready to be installed!
) else (
    echo ❌ APK build failed!
    pause
    exit /b 1
)

pause
