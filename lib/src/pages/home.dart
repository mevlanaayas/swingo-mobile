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
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            bottom: MediaQuery.of(context).padding.bottom + 33,
            left: MediaQuery.of(context).padding.left +
                MediaQuery.of(context).size.width / 25,
            right: MediaQuery.of(context).padding.right +
                MediaQuery.of(context).size.width / 25,
          ),
          child: Column(
            children: [
              Text("Explore", style: itemDetailHeadingStyle,),
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: HomeItem(
                      toPage: Senders(),
                      icon: FontAwesomeIcons.envelope,
                      text: "Senders",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Expanded(
                    child: HomeItem(
                      toPage: Carriers(),
                      icon: Icons.content_paste,
                      text: "Carriers",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
