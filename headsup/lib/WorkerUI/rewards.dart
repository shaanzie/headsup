import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RewardActivity extends StatefulWidget {
  RewardActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RewardActivityState createState() => _RewardActivityState();
}

class _RewardActivityState extends State<RewardActivity> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
