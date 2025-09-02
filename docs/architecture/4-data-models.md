# 4. Data Models

Based on the PRD, we need a core `Contest` model to represent the data fetched from third-party APIs. This model will be used throughout the application to display contest information.

## 4.1. Contest

**Purpose:** To represent a single coding contest.

**Key Attributes:**
-   `name`: String - The name of the contest.
-   `platform`: String - The platform hosting the contest (e.g., "LeetCode").
-   `startTime`: DateTime - The start date and time of the contest.
-   `url`: String - The URL to the contest page.
-   `duration`: String - The duration of the contest.
-   `isReminderSet`: bool - A client-side flag to track if a reminder has been set for this contest.

### 4.1.1. Dart Class

```dart
class Contest {
  final String name;
  final String platform;
  final DateTime startTime;
  final String url;
  final String duration;
  bool isReminderSet;

  Contest({
    required this.name,
    required this.platform,
    required this.startTime,
    required this.url,
    required this.duration,
    this.isReminderSet = false,
  });
}
```

### 4.1.2. Relationships

This model is self-contained and has no relationships with other data models in the MVP.

---