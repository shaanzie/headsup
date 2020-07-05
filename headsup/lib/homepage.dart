import 'package:flutter/material.dart';
import 'package:headsup/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ));
  }

  String _user;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = prefs.getString('user');
    print(prefs.getString('user'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: <Widget>[
          RaisedButton(
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.indigo,
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Text("Hello, $_user!"),
      ),
    );
  }
}
