import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const AlarmScreen({Key? key, required this.alarmSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contest Starting Soon!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              Text(
                alarmSettings.notificationSettings.title ?? 'Alarm',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Alarm.stop(alarmSettings.id).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: Text('Stop Alarm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
