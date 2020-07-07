import 'package:flutter/material.dart';
import 'package:headsup/ManagerUI/line_chart.dart';
import 'package:headsup/ManagerUI/pie_chart.dart';

class MyApp100 extends StatefulWidget {
  final String something;
  MyApp100({Key key, @required this.something}) : super(key: key);

  @override
  _MyApp100State createState() => _MyApp100State(something);
}

class _MyApp100State extends State<MyApp100> {
  String something;
  _MyApp100State(this.something);

  Widget _buildCard(String assetUrl, String title, int index, String title2) {
    print(title2);
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: deviceHeight * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PieChartSample1(
                            something: title2,
                          )));
            } else if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LineChartSample1(
                      something: title2,
                      type: 'Fatigue',
                    ),
                  ));
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
        title: Text("Fatigue Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/abg.png',
                'Distribution of waves (Pie Charts)', 1, something),
            SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/lc.png', 'Worker Fatigue Distribution', 2,
                something),
            /*SizedBox(
              height: 25,
            ),
            _buildCard('assets/images/piechart.jpg', 'Pie-Chart Example', 3)*/
          ],
        ),
      ),
    );
  }
}
