@echo off
echo ========================================
echo Contest Reminder - Build and Install
echo ========================================

echo.
echo What would you like to do?
echo 1. Build Debug APK (for testing)
echo 2. Build Release APK (for distribution) 
echo 3. Build and Install directly to connected device
echo 4. Check environment and connected devices
echo 5. Exit

echo.
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto debug_build
if "%choice%"=="2" goto release_build
if "%choice%"=="3" goto build_install
if "%choice%"=="4" goto check_env
if "%choice%"=="5" goto exit
goto invalid_choice

:debug_build
echo.
echo Building Debug APK...
call build_debug_apk.bat
goto end

:release_build
echo.
echo Building Release APK...
call build_apk.bat
goto end

:build_install
echo.
echo Building and installing to connected device...
echo.
echo [1/4] Cleaning previous builds...
call flutter clean

echo.
echo [2/4] Getting dependencies...
call flutter pub get

echo.
echo [3/4] Running code generation...
call flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo [4/4] Building and installing...
call flutter install

if %ERRORLEVEL% equ 0 (
    echo ✅ App successfully installed on your device!
) else (
    echo ❌ Installation failed. Make sure:
    echo   - Your device is connected via USB
    echo   - USB debugging is enabled
    echo   - Device is authorized for debugging
)
goto end

:check_env
echo.
call check_environment.bat
goto end

:invalid_choice
echo.
echo Invalid choice! Please select 1-5.
echo.
goto end

:exit
echo.
echo Goodbye!
goto end

:end
echo.
echo Press any key to exit...
pause > nul
