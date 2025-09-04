import 'package:alarm/alarm.dart';
import 'package:contest_reminder/features/alarms/presentation/alarm_screen.dart';
import 'package:contest_reminder/features/contest_list/presentation/contest_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Alarm.ringStream.stream.listen((alarmSettings) {
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => AlarmScreen(alarmSettings: alarmSettings),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Contest Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContestListScreen(),
    );
  }
}