# Technical Assumptions

## Repository Structure: Monorepo

For the initial development, a **Monorepo** structure is recommended. This will keep all the code for the mobile application in a single, easy-to-manage repository.

## Service Architecture: Serverless (Client-Side Only)

The MVP will employ a **client-side only architecture**. The application will not have its own dedicated backend. Instead, it will fetch contest data directly from the public APIs of third-party platforms like LeetCode and Codeforces.

## Testing Requirements: Unit + Integration

To ensure the reliability of the application, especially the critical alarm and API integration features, the testing strategy must include both **Unit Tests** (to validate individual components) and **Integration Tests** (to validate interactions between the app and third-party APIs).

## Additional Technical Assumptions and Requests

*   **Cross-Platform Framework:** The application must be built using a modern cross-platform framework, such as **Flutter or React Native**, to ensure efficient development and a consistent user experience across both iOS and Android.
*   **Native Alarm Integration:** This is the highest-risk technical feature. The architecture must support robust, reliable integration with the native system alarm APIs for both iOS and Android. A technical spike or proof-of-concept is required to validate this approach before full development.
*   **API Integration:** The architecture must be designed to handle interactions with multiple, external third-party APIs gracefully, including managing potential instability, rate limits, and errors.
*   **Secure Key Storage:** Any API keys used to access contest platform data must be stored securely within the client application, following platform-specific best practices (e.g., not hardcoded in source).
