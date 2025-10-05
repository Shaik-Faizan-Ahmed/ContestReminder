import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestAllAlarmPermissions(BuildContext? context) async {
    bool allPermissionsGranted = true;
    
    // Request system alert window permission (overlay permission)
    if (await Permission.systemAlertWindow.isDenied) {
      final result = await Permission.systemAlertWindow.request();
      if (result.isDenied) {
        print('System Alert Window permission denied - alarm screen may not show when app is closed');
        if (context != null) {
          _showPermissionDialog(context, 'Display over other apps', 
            'This permission is required to show the alarm screen when the app is closed.');
        }
        allPermissionsGranted = false;
      }
    }
    
    // Request notification permissions
    if (await Permission.notification.isDenied) {
      final result = await Permission.notification.request();
      if (result.isDenied) {
        print('Notification permission denied');
        allPermissionsGranted = false;
      }
    }
    
    // Request exact alarm permission for Android 12+
    if (await Permission.scheduleExactAlarm.isDenied) {
      final result = await Permission.scheduleExactAlarm.request();
      if (result.isDenied) {
        print('Schedule Exact Alarm permission denied');
        allPermissionsGranted = false;
      }
    }
    
    return allPermissionsGranted;
  }
  
  static Future<void> _showPermissionDialog(BuildContext context, String permissionName, String explanation) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Required'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(explanation),
              const SizedBox(height: 16),
              const Text(
                'Please grant this permission in Settings to ensure alarms work properly when the app is closed.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Later'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }
  
  static Future<bool> checkCriticalPermissions() async {
    final systemAlert = await Permission.systemAlertWindow.status;
    final notification = await Permission.notification.status;
    final exactAlarm = await Permission.scheduleExactAlarm.status;
    
    print('Permission Status:');
    print('- System Alert Window: $systemAlert');
    print('- Notification: $notification');
    print('- Exact Alarm: $exactAlarm');
    
    return systemAlert.isGranted && notification.isGranted;
  }
}
