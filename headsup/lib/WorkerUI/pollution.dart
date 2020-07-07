import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PollutionActivity extends StatefulWidget {
  PollutionActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PollutionActivityState createState() => _PollutionActivityState();
}

class _PollutionActivityState extends State<PollutionActivity> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  String _email;
  double _pollute = 0.0;
  TextEditingController calorieController = new TextEditingController();
  bool _isLoading = false;

  _getData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.get('email');
    final http.Response response = await http.post(
      'http://52.249.198.183:5000/api/v1/pollution',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'email': _email}),
    );
    if (response.statusCode == 200) {
      _pollute = double.parse(json.decode(response.body)['polIndex']);
    } else {
      throw Exception("User not found!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ambient Pollution"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Center(
                    child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        animationDuration: 4500,
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 1000,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 1000,
                                    endValue: 2000,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 2000,
                                    endValue: 3000,
                                    color: Colors.red,
                                    startWidth: 10,
                                    endWidth: 10)
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: _pollute,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text("$_pollute% Toxicity",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ]),
                  ),
                  FlatButton(
                    onPressed: _getData,
                    child: Text('Update Ambient Pollution'),
                  ),
                ],
              ));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
