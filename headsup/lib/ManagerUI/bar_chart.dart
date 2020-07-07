import 'package:fl_chart/fl_chart.dart';
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

class BarChartSample1 extends StatefulWidget {
  final String something;
  BarChartSample1({Key key, @required this.something}) : super(key: key);

  @override
  _BarChartSample1State createState() => _BarChartSample1State(something);
}

class _BarChartSample1State extends State<BarChartSample1> {
  String something;
  _BarChartSample1State(this.something);

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
    final http.Response response = await http.post(
      'http://137.135.89.132:5000/api/v1/pulldata',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'type': "person", "employeeID": something}),
    );
    if (response.statusCode == 201) {
      print(json.decode(response.body));
      _data = json.decode(response.body);
      print(_data);
      _rest = _data["data"] as List;
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
    final List<SalesData> chartData = [];
    if (_isLoading == false) {
      for (int i = 1; i <= listLength; i++) {
        listData = SalesData(i, _restMap[i - 1]);
        chartData.insert(i - 1, listData);
      }
    }
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(series: <ChartSeries>[
      ColumnSeries<SalesData, int>(
          dataSource: chartData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          // Sets the corner radius
          borderRadius: BorderRadius.all(Radius.circular(15)))
    ]))));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
