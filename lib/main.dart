import 'package:alarm/alarm.dart';
import 'package:contest_reminder/features/alarms/presentation/alarm_screen.dart';
import 'package:contest_reminder/features/contest_list/presentation/contest_list_screen.dart';
import 'package:contest_reminder/core/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _requestPermissions();
    Alarm.ringStream.stream.listen((alarmSettings) {
      print('Alarm triggered: ${alarmSettings.id}');
      print('Current context available: ${navigatorKey.currentContext != null}');
      print('Navigation state: ${navigatorKey.currentState != null}');
      
      // Try to navigate to alarm screen
      if (navigatorKey.currentState != null) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AlarmScreen(alarmSettings: alarmSettings),
            settings: const RouteSettings(name: '/alarm'),
          ),
          (route) => route.settings.name == '/' || route.settings.name == '/home',
        );
      } else {
        print('Navigator not available - app might need system alert window permission');
      }
    });
  }

  Future<void> _requestPermissions() async {
    // Use improved permission helper
    final allGranted = await PermissionHelper.requestAllAlarmPermissions(navigatorKey.currentContext);
    
    if (!allGranted) {
      print('Not all permissions granted - some alarm features may not work properly');
    }
    
    // Check and log permission status
    await PermissionHelper.checkCriticalPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Contest Reminder',
      theme: _buildTheme(),
      home: const ContestListScreen(),
    );
  }

  ThemeData _buildTheme() {
    const primaryColor = Color(0xFF6366F1); // Modern indigo
    const secondaryColor = Color(0xFF10B981); // Modern green
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ).copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        background: const Color(0xFFF8FAFC),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF374151),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF4B5563),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF6B7280),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}