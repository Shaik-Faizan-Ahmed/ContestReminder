# 15. Monitoring and Observability

## 15.1. Monitoring Stack

We will use the **Firebase** suite for monitoring, as it is well-integrated with Flutter and provides a comprehensive set of tools.

-   **Error Tracking:** **Firebase Crashlytics** will be used to automatically report crashes and non-fatal errors.
-   **Performance Monitoring:** **Firebase Performance Monitoring** will be used to measure app launch times and the performance of our API calls.
-   **Analytics:** **Firebase Analytics** will be used to gather anonymized data on user engagement, such as how many reminders are set.

## 15.2. Key Metrics

We will track the following key metrics to measure the health and success of the application:

**Stability Metrics:**
-   Crash-free users rate
-   API error rate

**Performance Metrics:**
-   App launch time
-   API response time from `clist.by`

**User Engagement Metrics:**
-   Daily/Monthly Active Users (DAU/MAU)
-   Number of reminders set per session
-   Number of reminders canceled
