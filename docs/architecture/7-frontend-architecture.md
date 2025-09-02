# 7. Frontend Architecture

## 7.1. Component Architecture

### 7.1.1. Component Organization

We will follow a feature-based folder structure. For our simple, single-screen MVP, this will be very straightforward:

```
lib/
├── main.dart                 # App entry point
└── features/
    └── contest_list/
        ├── data/
        │   ├── contest_repository.dart
        │   └── contest_service.dart
        ├── presentation/
        │   ├── providers/
        │   │   └── contest_providers.dart
        │   ├── widgets/
        │   │   └── contest_card.dart
        │   └── contest_list_screen.dart
        └── models/
            └── contest.dart
```

### 7.1.2. Component Template

All UI components will be `StatelessWidget` or `ConsumerWidget` (from Riverpod) to ensure a reactive and predictable UI.

```dart
import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget {
  const ContestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contest details will go here
          ],
        ),
      ),
    );
  }
}
```

## 7.2. State Management Architecture

We will use **Riverpod** for state management.

### 7.2.1. State Structure

The state will be managed by a `Notifier` that holds the list of contests.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ... other imports

@riverpod
class ContestList extends _$ContestList {
  @override
  Future<List<Contest>> build() async {
    // Initially, fetch the contests.
    // This will be handled by the repository.
    return _fetchContests();
  }

  Future<List<Contest>> _fetchContests() async {
    // ... logic to call the repository
  }

  void setReminder(String contestId) {
    // ... logic to update the reminder status for a contest
  }
}
```

### 7.2.2. State Management Patterns

-   **NotifierProvider:** To provide and manage the state of the contest list.
-   **FutureProvider:** To handle the initial asynchronous fetching of contest data from the API.
-   **ConsumerWidget:** To rebuild UI components when the state changes.

## 7.3. Routing Architecture

### 7.3.1. Route Organization

As this is a single-screen application, the routing will be minimal. The `main.dart` file will set up the `MaterialApp` and define the home screen.

```dart
import 'package:flutter/material.dart';
import 'package:contest_reminder/features/contest_list/presentation/contest_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contest Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ContestListScreen(),
    );
  }
}
```

### 7.3.2. Protected Route Pattern

Not applicable for the MVP, as there is no authentication.

## 7.4. Frontend Services Layer

### 7.4.1. API Client Setup

We will use the standard `http` package for making API calls to `clist.by`.

### 7.4.2. Service Example

A service class will encapsulate the logic for fetching data from the API.

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContestService {
  final String _baseUrl = "https://clist.by/api/v4";
  final String _apiKey = "YOUR_API_KEY"; // This will be stored securely

  Future<List<dynamic>> getUpcomingContests() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/contest/?upcoming=true&format=json&username=YOUR_USERNAME&api_key=$_apiKey')
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['objects'];
    } else {
      throw Exception('Failed to load contests');
    }
  }
}
```

---