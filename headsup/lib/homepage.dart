import 'package:flutter/material.dart';
import 'package:headsup/login_signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _logout() {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: <Widget>[
          RaisedButton(
            child: Text("LOGOUT"),
            color: Colors.transparent,
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
