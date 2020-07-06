import 'package:flutter/material.dart';
import 'package:headsup/login_signup.dart';
import 'package:headsup/WorkerUI/brain.dart';
import 'package:headsup/WorkerUI/calories.dart';
import 'package:headsup/WorkerUI/pollution.dart';
import 'package:headsup/WorkerUI/brain.dart';

class WorkerDashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<WorkerDashboard> {
  int touchedIndex = 0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 600, // card height
          child: PageView.builder(
            itemCount: 4,
            controller: PageController(viewportFraction: 0.8),
            onPageChanged: (int index) => setState(() => _index = index),
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
                            "Calorie Counter",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LandingPage(), // Change to Cal Count
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
                            "Ambient Pollution",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LandingPage(), // Change to Cal Count
                            ));
                      },
                    ));
              } else if (i == 2) {
                return Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: GestureDetector(
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Brain Activity",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LandingPage(), // Change to Cal Count
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
                            "Schedule",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LandingPage(), // Change to Cal Count
                            ));
                      },
                    ));
              }
            },
          ),
        ),
      ),
    );
  }
}