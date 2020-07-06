import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'WorkerUI/dashboard_worker.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  _checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('email') == null) {
      return SignInPage();
    } else {
      if (prefs.get('role') == 'supervisor') {
        return MyApp();
      } else {
        return WorkerDashboard();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _checkSignIn();
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  String role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Image.asset('assets/headsup.jpg'),
                    ),
                    TextFormField(
                      onSaved: (newValue) => _email = newValue,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Addresss"),
                    ),
                    TextFormField(
                      onSaved: (newValue) => _password = newValue,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text("LOGIN"),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        final form = _formKey.currentState;
                        form.save();
                        final http.Response response = await http.post(
                            'http://52.249.198.183:5000/api/v1/login',
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8'
                            },
                            body: jsonEncode(<String, String>{
                              'email': _email,
                              'password': _password
                            }));
                        prefs.setString('email', _email);

                        if (response.statusCode == 201) {
                          role = json.decode(response.body)['role'];
                          prefs.setString('role', role);
                          if (role == 'supervisor') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkerDashboard(),
                                ));
                          }
                        } else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        }
                      },
                    )
                  ],
                ))));
  }
}
