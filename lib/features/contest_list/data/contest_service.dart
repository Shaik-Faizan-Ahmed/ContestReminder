import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contest_reminder/features/contest_list/models/contest.dart';

class ContestService {
  final http.Client client;
  static const String _apiKey = '8f8b834849a15b8fb25f33abf1bee611ffbc6455';
  static const String _username = 'faizi29';
  static const String _authority = 'clist.by';
  static const String _apiPath = '/api/v4/contest/';

  ContestService(this.client);

  Future<List<Contest>> getUpcomingContests() async {
    // Get current time and add filter for upcoming contests
    final now = DateTime.now();
    final tomorrowStart = DateTime(now.year, now.month, now.day + 1);
    
    final uri = Uri.https(_authority, _apiPath, {
      'username': _username,
      'api_key': _apiKey,
      'start__gt': now.toUtc().toIso8601String(),
      'order_by': 'start',
      'limit': '50', // Limit to prevent too many results
    });

    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> contestObjects = data['objects'];
        
        // Parse contests and filter out past ones
        final contests = contestObjects
            .map((json) => Contest.fromJson(json))
            .where((contest) => contest.startTime.isAfter(now))
            .toList();
        
        return contests;
      } else {
        throw Exception('Failed to load contests. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching contests: $e');
      throw Exception('Failed to connect to the CLIST.by API. Please check your network connection.');
    }
  }
}
