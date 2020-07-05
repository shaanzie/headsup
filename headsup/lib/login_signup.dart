import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headsup/dashboard_manager.dart';
import 'package:headsup/dashboard_worker.dart';
import 'package:http/http.dart' as http;

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

class Credentials {
  final String email;
  final String password;

  Credentials({this.email, this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(email: json['email'], password: json['password']);
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
  Future<Credentials> dummy_val;

  Future<Credentials> responseCredentials(String email, String password) async {
    final http.Response response = await http.post(
        'http://52.249.198.183:5000/api/v1/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
    print("Request: " + email + " : " + password);
    print("Response: " + response.body);
    if (response.statusCode == 201) {
      return Credentials.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Login information',
                      style: TextStyle(fontSize: 20),
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
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        dummy_val = responseCredentials(_email, _password);
                        print("Dummy VAL: " + dummy_val.;
                        if (dummy_val != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                //if worker
                                builder: (context) => Dashboard(),
                                //else
                                //builder: (context) => Dashboard2(),
                              ));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  //if worker
                                  builder: (context) => LandingPage()));
                        }
                      },
                    )
                  ],
                ))));
  }
}
