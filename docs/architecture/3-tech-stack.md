# 3. Tech Stack

## 3.1. Technology Stack Table

| Category | Technology | Version | Purpose | Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **Frontend Language** | Dart | latest | Core language for Flutter | Required by the Flutter framework. |
| **Frontend Framework** | **Flutter** | **latest** | **Cross-platform UI toolkit** | **Recommended for its strong native integration capabilities, which are critical for the reliable alarm feature.** |
| **UI Component Library** | Material 3 | latest | UI components and styling | Specified in the `front-end-spec.md` for a modern, clean aesthetic. |
| **State Management** | Riverpod | latest | State management | A simple and powerful state management solution for Flutter that is compile-safe. |
| **API Style** | REST | N/A | Consuming third-party APIs | The contest platforms expose REST APIs. |
| **Frontend Testing** | flutter_test | SDK | Unit and widget testing | The standard testing framework for Flutter. |
| **E2E Testing** | integration_test | SDK | End-to-end testing | The official Flutter package for E2E testing. |
| **CI/CD** | GitHub Actions | latest | Continuous integration/delivery | A flexible and powerful CI/CD platform that is well-integrated with GitHub. |
| **Monitoring** | Firebase Crashlytics | latest | Crash reporting | A robust and easy-to-integrate crash reporting tool. |

---