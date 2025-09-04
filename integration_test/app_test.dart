import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:contest_reminder/main.dart';
import 'package:contest_reminder/features/contest_list/presentation/providers/contest_providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("set reminder and verify notification is scheduled",
      (WidgetTester tester) async {
    final container = ProviderContainer();
    // Initialize the alarm service before running the app
    await container.read(alarmServiceProvider).init();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Wait for contests to load by looking for the first card
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsWidgets);

    // Find the first contest card and tap the reminder button
    final reminderButton = find.byIcon(Icons.alarm_add).first;
    await tester.tap(reminderButton);
    await tester.pumpAndSettle();

    // The UI should update to show the alarm is on
    expect(find.byIcon(Icons.alarm_on).first, findsOneWidget);

    // Verify that the notification was scheduled.
    final alarmService = container.read(alarmServiceProvider);
    final pendingNotifications = await alarmService.getPendingNotifications();

    expect(pendingNotifications, isNotEmpty, reason: "No pending notifications found after setting reminder.");
  });
}
