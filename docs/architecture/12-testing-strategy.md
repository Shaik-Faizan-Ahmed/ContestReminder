# 12. Testing Strategy

We will follow the testing pyramid principle, focusing on a large base of fast and isolated unit tests, a good number of widget tests for our UI components, and a smaller set of comprehensive end-to-end tests.

## 12.1. Testing Pyramid

```
      /\
     /  \  <-- E2E (Integration) Tests
    /____\
   /      \ <-- Widget Tests
  /________\ 
 /          \<- Unit Tests
/____________\
```

## 12.2. Test Organization

All tests will be located in the `test/` directory, following standard Flutter conventions.

-   **Unit Tests:** These will be used to test individual functions, methods, and classes in isolation. This is where we will test our data models and the logic of our API service (by mocking the HTTP client).
-   **Widget Tests:** These will be used to test our UI components (widgets). We will verify that our widgets render correctly and respond to user interaction as expected.
-   **E2E (Integration) Tests:** These tests will run on a real device or simulator to automate and verify complete user flows, such as fetching the contest list, setting a reminder, and canceling it. We will use the `integration_test` package for this.

## 12.3. Test Examples

### 12.3.1. Unit Test Example (Service)

```dart
// test/features/contest_list/data/contest_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
// ... other imports

// Create a MockClient using the Mockito package
class MockClient extends Mock implements http.Client {}

void main() {
  test('returns a list of contests if the http call completes successfully', () async {
    final client = MockClient();
    final service = ContestService(client); // Assuming ContestService takes a client

    // Use Mockito to return a successful response when the http client is called.
    when(client.get(any)).thenAnswer((_) async => http.Response('{"objects": []}', 200));

    expect(await service.getUpcomingContests(), isA<List>());
  });
}
```

### 12.3.2. Widget Test Example (UI Component)

```dart
// test/features/contest_list/presentation/widgets/contest_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:contest_reminder/features/contest_list/presentation/widgets/contest_card.dart';
import 'package:contest_reminder/features/contest_list/models/contest.dart'; // Assuming Contest model is here
// ... other imports

void main() {
  testWidgets('ContestCard displays contest name and platform', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ContestCard(
          contest: Contest(name: 'Weekly Contest 395', platform: 'LeetCode', startTime: DateTime.now(), url: '', duration: ''), // Provide necessary args
        ),
      ),
    ));

    // Verify that the contest name and platform are displayed.
    expect(find.text('Weekly Contest 395'), findsOneWidget);
    expect(find.text('LeetCode'), findsOneWidget);
  });
}
```

### 12.3.3. E2E Test Example

```dart
// test_driver/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:contest_reminder/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tap on the reminder button changes its state', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the first reminder button. Assuming it's an IconButton with an alarm_add icon.
    final reminderButtonFinder = find.byIcon(Icons.alarm_add).first;

    // Verify the button is present before tapping
    expect(reminderButtonFinder, findsOneWidget);

    // Tap the button.
    await tester.tap(reminderButtonFinder);
    await tester.pumpAndSettle();

    // Verify the button's icon has changed to indicate the reminder is set.
    // Assuming the icon changes to Icons.alarm_on after tapping.
    expect(find.byIcon(Icons.alarm_on), findsOneWidget);
  });
}
```

---