import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/components/sw_welcome_button.dart';
import 'package:swingo/src/theme/part_style.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  static const double _horizontalPadding = 33;
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _onPressedSignIn() => Navigator.of(context).pushNamed('/signin');

  _onPressedSignUp() => Navigator.of(context).pushNamed('/signup');

  _onPressedHome() => Navigator.of(context).pop();

  _buildBody(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: WelcomeScreen._horizontalPadding
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
                height: height / 20
            ),
            Image.asset(
              'assets/images/swingo-logo.png',
              width: width / 4,
            ),
            Image.asset(
              'assets/images/swingo-earth.png',
              width: width / 4 * 3,
            ),
            SwButton(
              text: 'SIGN IN',
              onPressed: _onPressedSignIn,
              fillParent: true,
            ),
            SwButton(
              text: 'NEW USER',
              onPressed: _onPressedSignUp,
              fillParent: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: width / 20),
              child: SwHyperlink(
                onTap: _onPressedHome,
                color: secondaryColor.withOpacity(0.8),
                fontSize: 15,
                label: 'Continue without logged in')
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwPage(
      backgroundImage: new AssetImage('assets/images/swingo-cloud.png'),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: _buildBody()
        ),
      ),
    );
  }
}
