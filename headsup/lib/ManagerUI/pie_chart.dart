import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}
*/

class PieChartSample1 extends StatefulWidget {
  final String something;
  PieChartSample1({Key key, @required this.something}) : super(key: key);

  @override
  _PieChartSample1State createState() => _PieChartSample1State(something);
}

class _PieChartSample1State extends State<PieChartSample1> {
  String something;
  _PieChartSample1State(this.something);

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    _getData();
  }

  bool isShowingMainData;
  bool _isLoading = false;
  var _data;
  var _rest;
  var _restMap;
  int listLength;
  var listData;
  _getData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.post(
      'http://137.135.89.132:5000/api/v1/fatigue',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({"employeeID": something}),
    );
    if (response.statusCode == 201) {
      print(something);
      print(json.decode(response.body));
      _data = json.decode(response.body);
      print(_data);
      _rest = _data["sum"] as List;
      print(_rest);
      listLength = _rest.length;
      _restMap = _rest.asMap();
    } else {
      throw Exception("User not found!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [];
    if (_isLoading == false) {
      chartData.add(ChartData('Alpha', _restMap[0], 'Alpha'));
      chartData.add(ChartData('Beta', _restMap[1], 'Beta'));
      chartData.add(ChartData('Gamma', _restMap[2], 'Gamma'));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Wave distribution"),
        ),
        body: Center(
            child: Container(
                child: SfCircularChart(series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: chartData,
              //pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelMapper: (ChartData data, _) => data.text,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]))));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.text);
  final String x;
  final double y;
  final String text;
  //final Color color;
}
