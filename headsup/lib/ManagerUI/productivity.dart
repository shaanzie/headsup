import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/line_chart.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Productivity extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productivity',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyProductivity(title: 'Productivity'),
    );
  }
}

class MyProductivity extends StatefulWidget {
  MyProductivity({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyProductivity createState() => _MyProductivity();
}

class _MyProductivity extends State<MyProductivity> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Worker Detail - Productivity"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Expanded(
                    child: Text(
                      "Worker Productivity Details ",
                      style: TextStyle(
                        fontSize: 20,
                        height: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Center(
                child: SizedBox(
                  height: 400, // card height
                  child: PageView.builder(
                    itemCount: 3,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      if (i == 0) {
                        return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: GestureDetector(
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Worker 1",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LineChartSample1(
                                        something: "234",
                                        type: 'Productivity',
                                      ), // Change to Cal Count
                                    ));
                              },
                            ));
                      } else if (i == 1) {
                        return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: GestureDetector(
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Worker 2",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LineChartSample1(
                                        something: "567",
                                        type: 'Productivity',
                                      ), // Change to Cal Count
                                    ));
                              },
                            ));
                      } else {
                        return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: GestureDetector(
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "Worker 3",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LineChartSample1(
                                        something: "890",
                                        type: 'Productivity',
                                      ), // Change to Cal Count
                                    ));
                              },
                            ));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
