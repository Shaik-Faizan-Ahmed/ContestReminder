# 13. Coding Standards

## 13.1. Critical Fullstack Rules

-   **State Management:** State should be managed exclusively through Riverpod providers. Avoid using `StatefulWidget` for managing business or screen-level state.
-   **API Calls:** All network requests must be handled within the `data` layer (i.e., the `ContestRepository` and `ContestService`). UI components should never make direct API calls.
-   **Environment Variables:** Access secrets like the API key only through a dedicated configuration service that reads from secure storage. Never access them directly in the UI.
-   **Error Handling:** All asynchronous operations, especially API calls, must include robust error handling and provide clear feedback to the user.
-   **Immutability:** Treat state as immutable. When updating state, create a new object rather than modifying the existing one.

## 13.2. Naming Conventions

| Element | Convention | Example |
| :--- | :--- | :--- |
| Files | `snake_case.dart` | `contest_list_screen.dart` |
| Classes | `PascalCase` | `ContestCard` |
| Methods/Functions | `camelCase()` | `fetchContests()` |
| Variables | `camelCase` | `contestName` |
| Constants | `kCamelCase` | `kDefaultPadding` |

---