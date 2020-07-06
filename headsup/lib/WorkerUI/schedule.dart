import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:headsup/WorkerUI/dashboard_worker.dart';
import 'package:time_machine/time_machine.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class ScheduleActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

// And here's our widget !
    return WeekView(
      style: WeekViewStyle(
        dayBarHeight: 200,
        hourRowHeight: 40,
        dayViewWidth: 100,
        hoursColumnTextStyle: TextStyle(fontSize: 10, color: Colors.black87),
      ),
      dates: [
        date.subtract(Duration(days: 1)),
        date,
        date.add(Duration(days: 1))
      ],
      events: [
        FlutterWeekViewEvent(
          title: 'An event 1',
          description: 'A description 1',
          start: date.subtract(Duration(hours: 1)),
          end: date.add(Duration(hours: 18, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 2',
          description: 'A description 2',
          start: date.add(Duration(hours: 19)),
          end: date.add(Duration(hours: 22)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 3',
          description: 'A description 3',
          start: date.add(Duration(hours: 23, minutes: 30)),
          end: date.add(Duration(hours: 25, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 4',
          description: 'A description 4',
          start: date.add(Duration(hours: 20)),
          end: date.add(Duration(hours: 21)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 5',
          description: 'A description 5',
          start: date.add(Duration(hours: 20)),
          end: date.add(Duration(hours: 21)),
        ),
      ],
    );
  }
}
