import 'package:flutter/material.dart';
import 'package:headsup/homepage.dart';
import 'package:headsup/dashboard_worker.dart';

import 'dashboard_worker.dart';

class LandingPage extends StatelessWidget {
  checkSignIn() {}

  @override
  Widget build(BuildContext context) {
    // if (!checkSignIn()) {
    //   return SignInPage();
    // } else {
    //   return HomePage();
    // }
    return SignInPage();
  }
}

class SignInPage extends StatelessWidget {
  // _signIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              'Login information',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email Addresss"),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("LOGIN"),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      //if worker
                      builder: (context) => Dashboard(),
                      //else
                      //builder: (context) => Dashboard2(),
                    ));
              },
            )
          ],
        ));
  }
}
