import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CalorieActivity extends StatefulWidget {
  CalorieActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalorieActivityState createState() => _CalorieActivityState();
}

class _CalorieActivityState extends State<CalorieActivity> {
  bool _isLoading = false;
  String _eid;
  String _email;
  var _collect;
  var _steps;
  var _temp;
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
    _email = prefs.get('email');
    _eid = prefs.get('eid');
    final http.Response response = await http.post(
      'http://137.135.89.132:5000/api/v1/pulldata',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'type': "person", "employeeID": _eid}),
    );
    if (response.statusCode == 201) {
      _collect = json.decode(response.body)['data'];
    } else {
      throw Exception("User not found!");
    }
    setState(() {
      _isLoading = false;
    });
  }

  double _calories = 85.0;
  TextEditingController calorieController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calorie Counter"),
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
                              maximum: 3000,
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
                                  value: _calories,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text(
                                            "$_calories calories out of 3000",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ]),
                  ),
                  Center(
                    child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        animationDuration: 4500,
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: 20000,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 5000,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 5000,
                                    endValue: 10000,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 10000,
                                    endValue: 20000,
                                    color: Colors.red,
                                    startWidth: 10,
                                    endWidth: 10)
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: _calories,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text("$_steps today!",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ]),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: TextField(
                          decoration: new InputDecoration(
                              labelText: "Enter calories consumed"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: calorieController,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _calories += int.parse(calorieController.text);
                          _getData();
                        });
                      },
                      child: Text("Update count"),
                    ),
                  )
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
