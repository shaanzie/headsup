import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/bar_chart.dart';
import 'package:headsup/ManagerUI/line_chart.dart';
import 'package:headsup/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headsup/ManagerUI/pie_chart.dart';
import 'package:headsup/ManagerUI/productivity.dart';
import 'package:headsup/ManagerUI/fatigue.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Charts & Graphs demystified',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter-Charts & Graphs demystified'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int touchedIndex = 0;
  String _user;
  int _index = 0;
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
        appBar: AppBar(
          title: Text("Analytics Dashboard"),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.cyan,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
            )
          ],
        ),
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
                                                    'assets/images/productivity.png'),
                                              ),
                                              Text(
                                                "Productivity",
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
                                                Productivity(), // Change to Cal Count
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
                                                    'assets/images/worker.jpg'),
                                              ),
                                              Text(
                                                "Worker Count",
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
                                                BarChartSample1(
                                              something: "worker",
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                    'assets/images/fatigue.png'),
                                              ),
                                              Text(
                                                "Fatigue",
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
                                                Fatigue(), // Change to Cal Count
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
