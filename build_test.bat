@echo off
echo 🏁 Building Test Version of Contest Reminder...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    pause
    exit /b 1
)

echo 🧹 Cleaning previous builds...
flutter clean

echo 🗑️  Removing build cache...
if exist ".dart_tool" rmdir /s /q ".dart_tool"
if exist "build" rmdir /s /q "build"

echo 📦 Getting dependencies...
flutter pub get

echo 🔧 Building TEST APK (simple version)...
flutter build apk --release --target=lib/main_test.dart --split-per-abi

if %errorlevel% equ 0 (
    echo.
    echo ✅ Test APK built successfully!
    echo.
    echo 📱 APK Files Location:
    echo 📂 %CD%\build\app\outputs\flutter-apk\
    echo.
    echo 📋 Available APK files:
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" (
        echo    ✓ app-arm64-v8a-release.apk (Recommended for modern devices)
    )
    if exist "build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk" (
        echo    ✓ app-armeabi-v7a-release.apk (For older devices)
    )
    if exist "build\app\outputs\flutter-apk\app-x86_64-release.apk" (
        echo    ✓ app-x86_64-release.apk (For emulators)
    )
    echo.
    echo 🎯 Next Steps:
    echo    1. Navigate to: build\app\outputs\flutter-apk\
    echo    2. Install app-arm64-v8a-release.apk on your Android device
    echo    3. If this test works, run build_full.bat for complete app
    echo.
    
    REM Copy recommended APK to desktop for easy access
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" (
        copy "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" "%USERPROFILE%\Desktop\ContestReminder-Test.apk" >nul 2>&1
        if %errorlevel% equ 0 (
            echo 📋 Copied test APK to your Desktop as: ContestReminder-Test.apk
        )
    )
) else (
    echo ❌ Test APK build failed!
    pause
    exit /b 1
)

pause
