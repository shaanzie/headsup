import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/bar_chart.dart';
import 'package:headsup/ManagerUI/pie_chart.dart';
import 'package:headsup/ManagerUI/line_chart.dart';

//import 'package:shared_preferences/shared_preferences.dart';

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
  /*_logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ));
  }*/
  _logout() async {}
/*
  String _user;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = prefs.getString('email');
    print(_user);
  }*/
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel in vertical scrollable'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          } else {
            return Divider();
          }
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Carousel $carouselIndex'),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }
  
  Widget _buildCard(String assetUrl, String title, int index) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: deviceHeight * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            if (index == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BarChart()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LineChart()));
            } else if (index == 3) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PieChart()));
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: deviceHeight * 0.3,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage(assetUrl))),
              ),
              Container(
                margin: EdgeInsets.only(top: deviceHeight * 0.125),
                alignment: Alignment.center,
                child: Text(
                  title,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/barchart.jpg', 'Bar-Chart Example', 1),
            SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/linechart.png', 'Line-Chart Example', 2),
            SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/piechart.jpg', 'Pie-Chart Example', 3)
          ],
        ),
      ),
    );
  }*/

  int _index = 0;

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
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 600, // card height
          child: PageView.builder(
            itemCount: 3,
            controller: PageController(viewportFraction: 0.7),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      if (i == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarChartSample2()));
                      } else if (i == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LineChartSample1()));
                      } else if (i == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PieChartSample2()));
                      }
                    },
                    child: Text(
                      "Card ${i + 1}",
                      style: TextStyle(fontSize: 32),
                    ),
                  )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
