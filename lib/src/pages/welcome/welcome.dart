import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/theme/style.dart';

class WelcomeScreen extends StatefulWidget {
  static const double _horizontalPadding = 33;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _onPressedSignIn() => Navigator.of(context).pushNamed('/signin');

  _onPressedSignUp() => Navigator.of(context).pushNamed('/signup');

  _onPressedHome() => Navigator.of(context).pop();

  _buildBody() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: WelcomeScreen._horizontalPadding),
        child: Column(
          children: <Widget>[
            SizedBox(height: height / 50),
            Image.asset(
              'assets/images/swingo-logo.png',
              width: width / 4,
            ),
            Image.asset(
              'assets/images/swingo-earth.png',
              width: width / 4 * 3,
            ),
            SwButton(
              color: primaryColor,
              text: 'SIGN IN',
              onPressed: _onPressedSignIn,
              fillParent: true,
            ),
            SizedBox(
              height: 10,
            ),
            SwButton(
              color: primaryColor,
              text: 'NEW USER',
              onPressed: _onPressedSignUp,
              fillParent: true,
            ),
            Padding(
                padding: EdgeInsets.only(top: width / 7),
                child: SwHyperlink(
                  onTap: _onPressedHome,
                  color: textColor,
                  fontSize: 15,
                  label: 'Continue as a guest',
                )),
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
        body: SafeArea(child: _buildBody()),
      ),
    );
  }
}
