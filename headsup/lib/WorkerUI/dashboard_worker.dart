import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/productivity.dart';
import 'package:headsup/WorkerUI/rewards.dart';
import 'package:headsup/WorkerUI/schedule.dart';
import 'package:headsup/login_signup.dart';
import 'package:headsup/WorkerUI/calories.dart';
import 'package:headsup/WorkerUI/pollution.dart';
import 'package:headsup/WorkerUI/brain.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/browser_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibrate/vibrate.dart';
import 'package:eventsource/eventsource.dart';

sendAlert() async {
  EventSource eventSource = await EventSource.connect(
      'http://137.135.89.132:5000/api/v1/stream',
      client: new BrowserClient());

  eventSource.listen((event) {
    print("Event: ${event.event}");
    print("Data: ${event.data}");
  });
}

class MyAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FlatButton(
        child: Text(
          "Heads Up!",
          style: GoogleFonts.lato(fontSize: 50, color: Colors.white),
        ),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("Acknowledge"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Heads Up",
      style: GoogleFonts.lato(fontSize: 20),
    ),
    content: Text("WORKER 'value1@gmail.com' IN DANGER!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class WorkerDashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<WorkerDashboard> {
  int touchedIndex = 0;
  int _index = 0;
  String _user;
  bool _isLoading = false;
  bool _canVibrate = true;

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

  init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? print("This device can vibrate")
          : print("This device cannot vibrate");
    });
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
                    MyAlert(),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Expanded(
                        child: Text(
                          "Welcome back, '$_user'!",
                          style: GoogleFonts.neuton(
                              fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 600, // card height
                        child: PageView.builder(
                          itemCount: 5,
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
                                                    'assets/brain.png'),
                                              ),
                                              Text(
                                                "Productivity Index",
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
                            } else if (i == 3) {
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
                                                    'assets/reward.png'),
                                              ),
                                              Text(
                                                "Rewards",
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
                                                RewardActivity(), // Change to Cal Count
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
