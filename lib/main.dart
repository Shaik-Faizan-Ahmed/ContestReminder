import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contest_reminder/features/contest_list/presentation/contest_list_screen.dart';
import 'package:contest_reminder/features/alarms/alarm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize alarm service
    final alarmService = AlarmService();
    await alarmService.init();
    print('✅ Alarm service initialized successfully');
  } catch (e) {
    print('⚠️ Alarm service initialization failed: $e');
    // Continue anyway - app should still work without notifications
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contest Reminder',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const ContestListScreen(),
    );
  }
}
