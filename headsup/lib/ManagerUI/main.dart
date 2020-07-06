import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/bar_chart.dart';
import 'package:headsup/ManagerUI/line_chart.dart';
import 'package:headsup/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = prefs.get('email');
    print("User: " + _user);
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
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Expanded(
                    child: Text(
                      "Welcome back, '\$_user'",
                      style: TextStyle(
                        fontSize: 20,
                        height: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Center(
                child: SizedBox(
                  height: 500, // card height
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
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              colorFilter: new ColorFilter.mode(
                                                  Colors.black.withOpacity(0.7),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/productivity.png"))),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Productivity",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 29),
                                      ),
                                    )
                                  ],
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              colorFilter: new ColorFilter.mode(
                                                  Colors.black.withOpacity(0.7),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/worker.jpg"))),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Worker Count",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 29),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PieChartSample2(), // Change to Cal Count
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
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              colorFilter: new ColorFilter.mode(
                                                  Colors.black.withOpacity(0.7),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  "assets/images/fatigue.jpg"))),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Fatigue",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 29),
                                      ),
                                    )
                                  ],
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
