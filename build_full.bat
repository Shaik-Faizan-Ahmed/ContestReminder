@echo off
echo 🏁 Building Full Contest Reminder APK...

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

echo 📦 Getting dependencies...
flutter pub get

echo 🏗️  Running build runner for code generation...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo 🔧 Building FULL APK with all features...
flutter build apk --release --target=lib/main.dart --split-per-abi

if %errorlevel% equ 0 (
    echo.
    echo ✅ Full Contest Reminder APK built successfully!
    echo.
    echo 📱 APK Files Location:
    echo 📂 %CD%\build\app\outputs\flutter-apk\
    echo.
    echo 📋 Available APK files:
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" (
        echo    ✓ app-arm64-v8a-release.apk (Recommended - Modern devices)
        for %%i in ("build\app\outputs\flutter-apk\app-arm64-v8a-release.apk") do echo      Size: %%~zi bytes
    )
    if exist "build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk" (
        echo    ✓ app-armeabi-v7a-release.apk (Older devices)
        for %%i in ("build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk") do echo      Size: %%~zi bytes
    )
    if exist "build\app\outputs\flutter-apk\app-x86_64-release.apk" (
        echo    ✓ app-x86_64-release.apk (Emulators)
        for %%i in ("build\app\outputs\flutter-apk\app-x86_64-release.apk") do echo      Size: %%~zi bytes
    )
    echo.
    echo 🎯 Installation Instructions:
    echo    1. Transfer APK to your Android device
    echo    2. Enable "Install from Unknown Sources" in device settings
    echo    3. Install the APK file
    echo    4. Grant notification permissions when prompted
    echo.
    
    REM Copy recommended APK to desktop for easy access
    if exist "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" (
        copy "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" "%USERPROFILE%\Desktop\ContestReminder-Full.apk" >nul 2>&1
        if %errorlevel% equ 0 (
            echo 📋 Copied APK to your Desktop as: ContestReminder-Full.apk
        )
    )
    
    echo.
    echo 🎉 Contest Reminder with all features is ready!
) else (
    echo ❌ Full APK build failed!
    echo 💡 Try running build_test.bat first to debug issues
    pause
    exit /b 1
)

pause
