import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:contest_reminder/features/alarms/alarm_service.dart';
import 'package:contest_reminder/features/contest_list/data/contest_service.dart';
import 'package:contest_reminder/features/contest_list/models/contest.dart';

part 'contest_providers.g.dart';

@riverpod
ContestService contestService(ContestServiceRef ref) {
  return ContestService(http.Client());
}

@riverpod
AlarmService alarmService(AlarmServiceRef ref) {
  return AlarmService();
}

@riverpod
class ContestList extends _$ContestList {
  @override
  Future<List<Contest>> build() async {
    try {
      final contestService = ref.watch(contestServiceProvider);
      final contests = await contestService.getUpcomingContests();

      

      final now = DateTime.now();
      final sevenDaysFromNow = now.add(const Duration(days: 7));
      final allowedSites = ['leetcode.com', 'codechef.com', 'codeforces.com', 'hackerrank.com'];

      final filteredContests = contests.where((contest) {
        final contestDate = contest.startTime;
        final isAllowedSite = allowedSites.contains(contest.platform);
        return isAllowedSite &&
            contestDate.isAfter(now) &&
            contestDate.isBefore(sevenDaysFromNow);
      }).toList();
      
      // Sort contests by start time
      filteredContests.sort((a, b) => a.startTime.compareTo(b.startTime));
      
      return filteredContests;
    } catch (e, stackTrace) {
      
      rethrow;
    }
  }

  Future<void> setReminder(Contest contest, int reminderMinutes) async {
    try {
      final alarmService = ref.read(alarmServiceProvider);
      
      // Check if the contest is in the future
      if (contest.startTime.isBefore(DateTime.now().add(Duration(minutes: reminderMinutes)))) {
        throw Exception('Cannot set reminder for contests starting within $reminderMinutes minutes');
      }
      
      await alarmService.scheduleAlarm(
        contest.hashCode, 
        contest.startTime, 
        contest.name,
        reminderMinutes
      );
      
      // Update the state
      final contests = await future;
      state = AsyncData([
        for (final c in contests)
          if (c.name == contest.name && c.platform == contest.platform)
            c.copyWith(isReminderSet: true)
          else
            c,
      ]);
      
      
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> cancelReminder(Contest contest) async {
    try {
      final alarmService = ref.read(alarmServiceProvider);
      await alarmService.cancelAlarm(contest.hashCode);
      
      // Update the state
      final contests = await future;
      state = AsyncData([
        for (final c in contests)
          if (c.name == contest.name && c.platform == contest.platform)
            c.copyWith(isReminderSet: false)
          else
            c,
      ]);
      
      
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> refresh() async {
    try {
      state = const AsyncLoading();
      final contestService = ref.read(contestServiceProvider);
      final contests = await contestService.getUpcomingContests();

      

      final now = DateTime.now();
      final sevenDaysFromNow = now.add(const Duration(days: 7));
      final allowedSites = ['leetcode.com', 'codechef.com', 'codeforces.com', 'hackerrank.com'];

      final filteredContests = contests.where((contest) {
        final contestDate = contest.startTime;
        final isAllowedSite = allowedSites.contains(contest.platform);
        return isAllowedSite &&
            contestDate.isAfter(now) &&
            contestDate.isBefore(sevenDaysFromNow);
      }).toList();
      
      // Sort contests by start time
      filteredContests.sort((a, b) => a.startTime.compareTo(b.startTime));
      
      state = AsyncData(filteredContests);
    } catch (e, stackTrace) {
      
      state = AsyncError(e, stackTrace);
    }
  }
}
