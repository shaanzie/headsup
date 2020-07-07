import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'WorkerUI/dashboard_worker.dart';

class LandingPage extends StatelessWidget {
  _checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Role: " + prefs.get('email'));
    if (prefs.get('email') == null) {
      return 0;
    } else {
      if (prefs.get('role') == 'supervisor') {
        return 1;
      } else {
        return 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkSignIn() == 0) {
      return SignInPage();
    } else if (_checkSignIn() == 1) {
      return MyApp();
    } else {
      return WorkerDashboard();
    }
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
  String eid;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: SizedBox(
                            child: Image.asset('assets/headsup.jpg'),
                            height: 200,
                          ),
                        ),
                        TextFormField(
                          onSaved: (newValue) => _email = newValue,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(labelText: "Email Address"),
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
                            setState(() {
                              _isLoading = true;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            final form = _formKey.currentState;
                            form.save();
                            final http.Response response = await http.post(
                                'http://137.135.89.132:5000/api/v1/login',
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8'
                                },
                                body: jsonEncode(<String, String>{
                                  'email': _email,
                                  'password': _password
                                }));
                            prefs.setString('email', _email);

                            if (response.statusCode == 201) {
                              role = json.decode(response.body)['role'];
                              print(response.body);
                              eid = json.decode(response.body)['employeeID'];
                              prefs.setString('role', role);
                              prefs.setString('eid', eid);
                              print("Eid: " + prefs.getString('eid'));
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            }
                          },
                        )
                      ],
                    ))));
  }
}
