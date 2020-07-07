import 'package:flutter/material.dart';
import 'package:headsup/WorkerUI/schedule.dart';
import 'package:headsup/login_signup.dart';
import 'package:headsup/WorkerUI/calories.dart';
import 'package:headsup/WorkerUI/pollution.dart';
import 'package:headsup/WorkerUI/brain.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerDashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<WorkerDashboard> {
  int touchedIndex = 0;
  int _index = 0;
  String _user;
  bool _isLoading = false;

  _getUser() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = prefs.get('email');
    print("User: " + _user);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Expanded(
                          child: Text(
                            "Welcome back, '$_user'!",
                            style: GoogleFonts.neuton(
                                fontSize: 50, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Center(
                      child: SizedBox(
                        height: 600, // card height
                        child: PageView.builder(
                          itemCount: 4,
                          controller: PageController(viewportFraction: 0.9),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                    'assets/calorie.jpg'),
                                              ),
                                              Text(
                                                "Calorie Counter",
                                                style: GoogleFonts.neuton(
                                                  fontSize: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CalorieActivity(), // Change to Cal Count
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                    'assets/pollution.jpg'),
                                              ),
                                              Text(
                                                "Ambient Pollution",
                                                style: GoogleFonts.neuton(
                                                  fontSize: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PollutionActivity(), // Change to Cal Count
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                    'assets/brain.png'),
                                              ),
                                              Text(
                                                "Brain Activity",
                                                style: GoogleFonts.neuton(
                                                  fontSize: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BrainActivity(), // Change to Cal Count
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                    'assets/schedule.png'),
                                              ),
                                              Text(
                                                "Schedule",
                                                style: GoogleFonts.neuton(
                                                  fontSize: 50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleActivity(), // Change to Cal Count
                                          ));
                                    },
                                  ));
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: FlatButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: Text(
                          "LOGOUT",
                          style: GoogleFonts.neuton(
                              fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.black12,
                      ),
                    )
                  ],
                ),
        ));
  }
}
