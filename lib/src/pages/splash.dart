import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashScreen extends StatefulWidget {
  final requestFn;

  SplashScreen({this.requestFn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAnimatedSplash() {
    return FlareActor(
      'assets/flare/SuccessCheck.flr',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: 'Untitled',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
      body: SafeArea(
          child: _buildAnimatedSplash(),),
    );
  }
}
