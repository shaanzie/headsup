import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class BrainActivity extends StatefulWidget {
  @override
  _BrainState createState() => _BrainState();
}

class _BrainState extends State<BrainActivity> {
  String _email;
  String _collect;
  List<double> _data;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.get('email');
    final http.Response response = await http.post(
      'http://52.249.198.183:5000/api/v1/brain',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'email': _email}),
    );
    if (response.statusCode == 200) {
      _collect = json.decode(response.body)['data'];
      List<String> _splitData = _collect.split(',');
      for (int i = 0; i < _splitData.length; i++) {
        _data.add(double.parse(_splitData[i]));
      }
    } else {
      throw Exception("User not found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BrainData> chartData;
    for (int i = 0; i < _data.length; i++) {
      chartData.add(BrainData(i, _data[i]));
    }

    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);
    return Scaffold(
      appBar: AppBar(
        title: Text("Brain Activity"),
      ),
      body: Center(
        child: Container(
          child: SfCartesianChart(
            series: <ChartSeries>[
              // Renders area chart
              AreaSeries<BrainData, int>(
                  dataSource: chartData,
                  xValueMapper: (BrainData brain, _) => brain.year,
                  yValueMapper: (BrainData brain, _) => brain.brainProf,
                  gradient: gradientColors)
            ],
          ),
        ),
      ),
    );
  }
}

class BrainData {
  BrainData(this.year, this.brainProf);
  final int year;
  final double brainProf;
}
