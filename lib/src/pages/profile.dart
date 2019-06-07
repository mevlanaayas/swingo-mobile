import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/sw_card.dart';
import 'package:swingo/src/theme/style.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom + 33,
            left: MediaQuery.of(context).padding.left +
                MediaQuery.of(context).size.width / 25,
            right: MediaQuery.of(context).padding.right +
                MediaQuery.of(context).size.width / 25,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MenuItem(
                      toRoute: "/chat",
                      icon: FontAwesomeIcons.envelope,
                      text: "Messages",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Expanded(
                    child: MenuItem(
                      toRoute: "/orders",
                      icon: Icons.content_paste,
                      text: "Orders",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MenuItem(
                      toRoute: "/bids",
                      icon: FontAwesomeIcons.dollarSign,
                      text: "Bids",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Expanded(
                    child: MenuItem(
                      toRoute: "/settings",
                      icon: FontAwesomeIcons.userCog,
                      text: "Settings",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MenuItem(
                      toRoute: "/matches",
                      icon: FontAwesomeIcons.equals,
                      text: "Matches",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Expanded(
                    child: MenuItem(
                      toRoute: "/logout",
                      icon: FontAwesomeIcons.signOutAlt,
                      text: "Sign Out",
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
