import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/components/sw_welcome_button.dart';
import 'package:swingo/src/theme/part_style.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/warmup_flare.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

const double _horizontalPadding = 33;

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageStyle pageStyle;
  Timer _swapPartTimer;

  final Timer _warmupTimer =
      Timer(const Duration(milliseconds: 1500), warmupFlare);

  @override
  void initState() {
    _choosePart();
    super.initState();
  }

  void _choosePart() {
    setState(() {
      pageStyle = PageStyle.random();
    });
    _startTimer();
  }

  void _startTimer() {
    _swapPartTimer?.cancel();
    _swapPartTimer = Timer(const Duration(seconds: 10), _choosePart);
  }

  @override
  void dispose() {
    super.dispose();
    _swapPartTimer?.cancel();
    _warmupTimer.cancel();
  }

  Future<void> _pressSignin() async {
    _swapPartTimer?.cancel();
    await Navigator.of(context).pushNamed('/signin');
    _startTimer();
  }

  Future<void> _pressSignup() async {
    _swapPartTimer?.cancel();
    await Navigator.of(context).pushNamed('/signup');
    _startTimer();
  }

  Future<void> _pressHome() async {
    _swapPartTimer?.cancel();
    await Navigator.of(context).pushNamed('/home');
    _startTimer();
  }

  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    // Hide window chrome.
    var query = MediaQuery.of(context);
    var width = query.size.width;
    if (!_initialized && width != 0 && width < blockLandscapeThreshold) {
      // Disallow rotating to landscape.
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // add pageStyle.contentColor here to customize bg color of welcome page
        color: contentColor,
        child: SingleChildScrollView(
          child: _WelcomeScreenSlim(
              signIn: _pressSignin,
              signUp: _pressSignup,
              home: _pressHome,
              part: pageStyle),
        ),
      ),
    );
  }
}

/// Builds the slim version of the welcome screen (usually shown
/// on portrait mobile devices).
class _WelcomeScreenSlim extends StatelessWidget {
  final VoidCallback signIn;
  final VoidCallback signUp;
  final VoidCallback home;
  final PageStyle part;

  const _WelcomeScreenSlim({this.signIn, this.signUp, this.home, this.part});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 83,
          bottom: 56,
          left: _horizontalPadding,
          right: _horizontalPadding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: modalMaxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(part),
            Padding(
              padding: const EdgeInsets.only(top: 29, bottom: 15),
              child: WelcomeButton(
                  key: const Key('login'),
                  onPressed: signIn,
                  background: primaryColor,
                  icon: FontAwesomeIcons.signInAlt,
                  label: 'Sign In'),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: WelcomeButton(
                  onPressed: signUp,
                  background: secondaryColor,
                  icon: FontAwesomeIcons.userCheck,
                  label: 'Sign Up'),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: SwHyperlink(
                  onTap: home,
                  color: secondaryColor.withOpacity(0.5),
                  fontSize: 15,
                  label: 'Continue as a guest'),
            )
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final PageStyle part;

  _Title(this.part);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          part.name,
          style: TextStyle(
              fontFamily: 'RobotoCondensedBold',
              fontSize: 30,
              letterSpacing: 5),
        ),
        SizedBox(height: 12),
        Container(
          height: 2,
          color: Colors.white.withOpacity(0.19),
        ),
        Image.asset(part.logo, bundle: DefaultAssetBundle.of(context)),
        SizedBox(height: 12),
        Text(
          part.description,
          style: TextStyle(fontFamily: 'RobotoRegular', fontSize: 20),
        ),
        const SizedBox(height: 25)
      ],
    );
  }
}
