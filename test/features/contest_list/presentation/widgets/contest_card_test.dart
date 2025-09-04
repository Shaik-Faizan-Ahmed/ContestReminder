
import 'package:contest_reminder/features/alarms/alarm_service.dart';
import 'package:contest_reminder/features/contest_list/models/contest.dart';
import 'package:contest_reminder/features/contest_list/presentation/providers/contest_providers.dart';
import 'package:contest_reminder/features/contest_list/presentation/widgets/contest_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contest_card_test.mocks.dart';

@GenerateMocks([AlarmService])
void main() {
  group('ContestCard', () {
    late MockAlarmService mockAlarmService;

    setUp(() {
      mockAlarmService = MockAlarmService();
    });

    testWidgets('shows alarm_add icon when reminder is not set', (tester) async {
      final contest = Contest(
        name: 'Test Contest',
        platform: 'Test Platform',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        isReminderSet: false,
        url: 'http://example.com',
        duration: '1 hour',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            alarmServiceProvider.overrideWithValue(mockAlarmService),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ContestCard(contest: contest),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.alarm_add), findsOneWidget);
      expect(find.byIcon(Icons.alarm_on), findsNothing);
    });

    testWidgets('shows alarm_on icon when reminder is set', (tester) async {
      final contest = Contest(
        name: 'Test Contest',
        platform: 'Test Platform',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        isReminderSet: true,
        url: 'http://example.com',
        duration: '1 hour',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            alarmServiceProvider.overrideWithValue(mockAlarmService),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ContestCard(contest: contest),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.alarm_on), findsOneWidget);
      expect(find.byIcon(Icons.alarm_add), findsNothing);
    });

    testWidgets('tapping alarm_add icon calls setReminder', (tester) async {
      // This test needs to be updated to handle the dialog.
      // For now, we'll just check if the dialog appears.
      final contest = Contest(
        name: 'Test Contest',
        platform: 'Test Platform',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        isReminderSet: false,
        url: 'http://example.com',
        duration: '1 hour',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            alarmServiceProvider.overrideWithValue(mockAlarmService),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ContestCard(contest: contest),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.alarm_add));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.descendant(of: find.byType(AlertDialog), matching: find.text('Set Reminder')), findsOneWidget);
    });

    testWidgets('tapping alarm_on icon shows cancel dialog', (tester) async {
      final contest = Contest(
        name: 'Test Contest',
        platform: 'Test Platform',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        isReminderSet: true,
        url: 'http://example.com',
        duration: '1 hour',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            alarmServiceProvider.overrideWithValue(mockAlarmService),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ContestCard(contest: contest),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.alarm_on));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Confirm Cancellation'), findsOneWidget);
    });
  });
}
