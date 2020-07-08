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

  String _eid;
  double _pollute = 0.0;
  TextEditingController calorieController = new TextEditingController();
  bool _isLoading = false;

  _getData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _eid = prefs.get('eid');
    final http.Response response = await http.post(
      'http://137.135.89.132:5000/api/v1/pollution',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'employeeID': _eid}),
    );
    if (response.statusCode == 201) {
      _pollute = double.parse(json.decode(response.body)['data']);
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
                  SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        animationDuration: 2000,
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 30,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 60,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 60,
                                    endValue: 150,
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
                                        child: Text("$_pollute ppm Toxicity",
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
