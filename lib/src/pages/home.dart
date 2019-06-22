import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/pages/carriers.dart';
import 'package:swingo/src/pages/senders.dart';
import 'package:swingo/src/theme/style.dart';

class HomePage extends StatefulWidget {
  final Filter filter;

  HomePage({this.filter});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor,
        child: Padding(
          padding: EdgeInsets.only(top: size / 3, bottom: size / 3 + 33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: HomeItem(
                      toPage: Senders(),
                      icon: FontAwesomeIcons.arrowsAlt,
                      text: "Senders",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(""),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: HomeItem(
                      toPage: Carriers(),
                      icon: Icons.send,
                      text: "Carriers",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
