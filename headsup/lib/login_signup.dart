import 'package:flutter/material.dart';
import 'package:headsup/dashboard_manager.dart';
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

  int dummy_val = 1;
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
                if (dummy_val == 1) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          //builder: (context) => Dashboard2(), UNCOMMENT THIS
                          ));
                }
              },
            )
          ],
        ));
  }
}
