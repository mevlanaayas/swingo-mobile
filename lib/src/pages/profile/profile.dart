import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/sw_card.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/profile/base.dart';
import 'package:swingo/src/pages/profile/chat.dart';
import 'package:swingo/src/pages/profile/matches.dart';
import 'package:swingo/src/pages/profile/settings.dart';
import 'package:swingo/src/theme/style.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double spaceWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: Container(
        alignment: Alignment(0.0, 0.0),
        height: MediaQuery.of(context).size.height,
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom + 33),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ProfileItem(
                      toPage: BaseProfile(child: ChatPage(), type: "Inbox"),
                      icon: FontAwesomeIcons.envelope,
                      text: "Inbox",
                      right: false,
                    ),
                  ),
                  SizedBox(
                    width: spaceWidth,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: spaceWidth,
                  ),
                  Expanded(
                    child: ProfileItem(
                      toPage:
                          BaseProfile(child: MatchesScreen(), type: "Matches"),
                      icon: FontAwesomeIcons.equals,
                      text: "Matches",
                      right: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ProfileItem(
                      toPage: BaseProfile(child: BidsScreen(), type: "Bids"),
                      icon: FontAwesomeIcons.dollarSign,
                      text: "Bids",
                      right: false,
                    ),
                  ),
                  SizedBox(
                    width: spaceWidth,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: spaceWidth,
                  ),
                  Expanded(
                    child: ProfileItem(
                      toPage:
                          BaseProfile(child: OrdersScreen(), type: "MY ORDERS"),
                      icon: Icons.content_paste,
                      text: "Orders",
                      right: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ProfileItem(
                      toPage: BaseProfile(
                          child: SettingsScreen(), type: "Settings"),
                      icon: FontAwesomeIcons.userCog,
                      text: "Settings",
                      right: false,
                    ),
                  ),
                  SizedBox(
                    width: spaceWidth,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: spaceWidth,
                  ),
                  Expanded(
                    child: ProfileItem(
                      toPage: BaseProfile(
                          child: SettingsScreen(), type: "Settings"),
                      icon: FontAwesomeIcons.signOutAlt,
                      text: "Sign Out",
                      right: true,
                    ),
                  ),
                ],
              ),
              /*
              Row(
                children: <Widget>[
                  Expanded(
                    child: MenuItem(
                      toRoute: "/route",
                      icon: FontAwesomeIcons.signOutAlt,
                      text: "Sign Out",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 25,
              ),
               */
            ],
          ),
        ),
      ),
    );
  }
}
