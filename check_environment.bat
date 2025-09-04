@echo off
echo ========================================
echo Contest Reminder Build Environment Check
echo ========================================

echo.
echo Checking Flutter installation...
flutter doctor -v

echo.
echo Checking if connected devices are available...
flutter devices

echo.
echo Checking project dependencies...
flutter pub deps

echo.
echo ========================================
echo Environment Check Complete!
echo ========================================
echo.
echo If Flutter doctor shows any issues, please resolve them before building.
echo.
echo Press any key to exit...
pause > nul
