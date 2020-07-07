import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RewardActivity extends StatefulWidget {
  RewardActivity({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RewardActivityState createState() => _RewardActivityState();
}

class _RewardActivityState extends State<RewardActivity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rewards"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/phone.png'),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Reward 1",
                              style: GoogleFonts.corben(fontSize: 30),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Points: 200",
                              style: GoogleFonts.corben(fontSize: 20),
                            ),
                          ),
                          Center(
                            child: FlatButton(
                              child: Text(
                                "AVAIL",
                                style: GoogleFonts.aladin(fontSize: 20),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/phone.png'),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Reward 2",
                              style: GoogleFonts.corben(fontSize: 30),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Points: 400",
                              style: GoogleFonts.corben(fontSize: 20),
                            ),
                          ),
                          Center(
                            child: FlatButton(
                              child: Text(
                                "AVAIL",
                                style: GoogleFonts.aladin(fontSize: 20),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/phone.png'),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Reward 3",
                              style: GoogleFonts.corben(fontSize: 30),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Points: 500",
                              style: GoogleFonts.corben(fontSize: 20),
                            ),
                          ),
                          Center(
                            child: FlatButton(
                              child: Text(
                                "AVAIL",
                                style: GoogleFonts.aladin(fontSize: 20),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
