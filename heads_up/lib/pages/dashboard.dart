import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heads_up/services/authentication.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();
  }

  Material myItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: new Color(color),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),

                  //Icons
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            new FlatButton(
                onPressed: signOut,
                child: new Text(
                  'Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white),
                ))
          ],
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2, //number of columns
          crossAxisSpacing: 12.0, //spacing between columns)
          mainAxisSpacing: 12.0, //Horizontal spacing
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            myItems(Icons.graphic_eq, "YOUR MOM", 0xffed622b),
            myItems(Icons.graphic_eq, "YOUR MOM_v2", 0xffed622b),
            myItems(Icons.graphic_eq, "YOUR MOM_v3", 0xffed622b),
            myItems(Icons.graphic_eq, "YOUR MOM_v4", 0xffed622b),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 130.0),
            StaggeredTile.extent(1, 150.0),
            StaggeredTile.extent(1, 150.0),
            StaggeredTile.extent(2, 130.0),
          ],
        ));
  }
}
