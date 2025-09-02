# 11. Security and Performance

## 11.1. Security Requirements

**Application Security:**
-   **API Key Storage:** The `CLIST_API_KEY` is the most sensitive piece of information in the application. To protect it, we will use the `flutter_secure_storage` package, which utilizes hardware-backed secure storage mechanisms on both iOS (Keychain) and Android (Keystore). This is significantly more secure than storing it in source code or a bundled environment file.
-   **Network Security:** All communication with the `clist.by` API will be over HTTPS.

**Backend Security:**
-   Not applicable for the MVP.

**Authentication Security:**
-   Not applicable for the MVP.

## 11.2. Performance Optimization

**Application Performance:**
-   **Bundle Size Target:** We will aim to keep the initial download size of the application under 20MB to ensure a quick and easy installation for users.
-   **Loading Strategy:** While fetching the initial contest list, the UI will display a skeleton loading screen (e.g., with a shimmer effect). This provides immediate visual feedback and improves the perceived performance of the app.
-   **Caching Strategy:** The fetched contest list will be cached in memory to avoid re-fetching on every app launch. We will implement a short-term caching mechanism (e.g., 5-10 minutes) to ensure the data is reasonably fresh without making excessive API calls.

---