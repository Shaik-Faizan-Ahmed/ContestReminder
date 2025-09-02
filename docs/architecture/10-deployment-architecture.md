# 10. Deployment Architecture

## 10.1. Deployment Strategy

Since this is a mobile application, deployment means publishing to the app stores.

**Application Deployment:**
-   **Platform:** Apple App Store and Google Play Store.
-   **Build Command:** `flutter build ipa` for iOS and `flutter build appbundle` for Android.
-   **Output Directory:** `build/ios/` for iOS and `build/app/` for Android.

## 10.2. CI/CD Pipeline

We will use GitHub Actions for our CI/CD pipeline. The following workflow will run on every push to the `main` branch to ensure the app builds correctly and all tests pass.

```yaml
# .github/workflows/ci.yaml

name: Build and Test

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        channel: 'stable'

    - name: Install dependencies
      run: flutter pub get

    - name: Run tests
      run: flutter test

    - name: Build Android App Bundle
      run: flutter build appbundle

    # Note: Building for iOS requires a macOS runner
    # This is a simplified example.
    # - name: Build iOS App
    #   run: flutter build ipa
```

## 10.3. Environments

| Environment | Platform | Purpose |
| :--- | :--- | :--- |
| **Development** | Local Simulator/Device | Day-to-day development and debugging. |
| **Staging** | TestFlight (iOS) & Google Play Internal Testing (Android) | Internal testing and QA before a production release. |
| **Production** | Apple App Store & Google Play Store | The live application available to all users. |

---