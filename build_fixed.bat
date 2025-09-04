@echo off
echo 🏁 Building Contest Reminder APK (Fixed Version)...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    pause
    exit /b 1
)

echo 🧹 Cleaning previous builds...
flutter clean

echo 📦 Getting dependencies...
flutter pub get

echo 🏗️  Running build runner for code generation...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo 🔧 Building APK with multiple options...
echo.

REM Try split APKs first
echo 📱 Attempting to build split APKs...
flutter build apk --release --target=lib/main.dart --split-per-abi

if %errorlevel% neq 0 (
    echo ⚠️  Split APK build failed, trying universal APK...
    flutter build apk --release --target=lib/main.dart
)

echo.
echo 📂 Checking what APK files were created...
echo.

if exist "build\app\outputs\flutter-apk\" (
    echo ✅ APK build completed!
    echo 📱 APK Files found:
    
    dir "build\app\outputs\flutter-apk\*.apk" /B 2>nul
    
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" (
        echo    ✓ app-arm64-v8a-release.apk (64-bit ARM - Recommended)
        copy "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" "%USERPROFILE%\Desktop\ContestReminder.apk" >nul 2>&1
    ) else if exist "build\app\outputs\flutter-apk\app-release.apk" (
        echo    ✓ app-release.apk (Universal APK - Works on all devices)
        copy "build\app\outputs\flutter-apk\app-release.apk" "%USERPROFILE%\Desktop\ContestReminder.apk" >nul 2>&1
    )
    
    echo.
    echo 📋 APK copied to Desktop as: ContestReminder.apk
    echo 📂 Original location: %CD%\build\app\outputs\flutter-apk\
    
) else (
    echo ❌ No APK files found! Build may have failed.
)

pause
