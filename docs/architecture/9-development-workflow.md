# 9. Development Workflow

## 9.1. Local Development Setup

### 9.1.1. Prerequisites

-   **Flutter SDK:** Install the latest stable version of the Flutter SDK.
-   **IDE:** Android Studio or Visual Studio Code with the official Flutter extension.
-   **iOS/Android Simulators:** Set up an iOS Simulator (on macOS) or an Android Emulator.

### 9.1.2. Initial Setup

```bash
# Clone the repository
git clone <repository_url>
cd ContestReminder

# Install dependencies
flutter pub get
```

### 9.1.3. Development Commands

```bash
# Run the app in debug mode
flutter run

# Run all tests
flutter test

# Build the release version of the app
flutter build apk
flutter build ipa
```

## 9.2. Environment Configuration

### 9.2.1. Required Environment Variables

We will use the `flutter_dotenv` package to manage environment variables. Create a `.env` file in the root of the project with the following content:

```
# .env

# Your API key from clist.by
CLIST_API_KEY="your_api_key_here"
CLIST_USERNAME="your_username_here"
```

This file should be added to `.gitignore` and should never be committed to version control.

---