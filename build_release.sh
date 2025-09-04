#!/bin/bash

# Contest Reminder - Build Release APK Script

echo "🏁 Starting Contest Reminder APK Build Process..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "📋 Flutter Doctor Check..."
flutter doctor

echo "🧹 Cleaning previous builds..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get

echo "🏗️  Running build runner for code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo "🔧 Building release APK..."
flutter build apk --release --split-per-abi

if [ $? -eq 0 ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK files are located at:"
    echo "   - build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
    echo "   - build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk"
    echo "   - build/app/outputs/flutter-apk/app-x86_64-release.apk"
    echo ""
    echo "🎉 Contest Reminder is ready to be installed!"
else
    echo "❌ APK build failed!"
    exit 1
fi
