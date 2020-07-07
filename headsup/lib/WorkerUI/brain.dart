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
  String _eid;
  var _collect;
  var _label;
  List<double> _data = List<double>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _eid = prefs.get('eid');
    final http.Response response = await http.post(
      'http://137.135.89.132:5000/api/v1/pulldata',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'type': "person", "employeeID": _eid}),
    );
    if (response.statusCode == 201) {
      _label = json.decode(response.body);
      _collect = _label['data'] as List;
      for (int i = 0; i < _collect.length; i++) {
        print('Collect: ' + _collect[i].toString());
        _data.add(_collect[i]);
      }
      // print(_data.runtimeType);
    } else {
      throw Exception("User not found!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BrainData> chartData = List<BrainData>();
    if (_isLoading == false) {
      for (int i = 1; i <= _data.length; i++) {
        chartData.add(BrainData(i, _data[i - 1]));
      }
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: 'Timestamp'),
                  ),
                  primaryYAxis: CategoryAxis(
                      title: AxisTitle(text: 'Productivity Index')),
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
