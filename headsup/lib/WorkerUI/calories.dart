import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CalorieActivity extends StatefulWidget {
  CalorieActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalorieActivityState createState() => _CalorieActivityState();
}

class _CalorieActivityState extends State<CalorieActivity> {
  @override
  void initState() {
    super.initState();
  }

  double _calories = 85.0;
  TextEditingController calorieController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calorie Counter"),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  animationDuration: 4500,
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: 3000, ranges: <GaugeRange>[
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
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: _calories,
                      )
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child: Text("$_calories calories out of 3000",
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
