import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:swingo/src/theme/style.dart';

class LoadingScreen extends StatefulWidget {
  final requestFn;
  final parentContext;

  LoadingScreen({this.requestFn, this.parentContext});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  double initialRadius = 75;
  double radius = 75;
  bool isDotsAreHide = true;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          1,
          curve: Curves.linear,
        )));

    controller.repeat();
    //Fixme: performance problems
/*
    animationRadiusIn = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.75,
          1,
          curve: Curves.elasticIn,
        )));

    animationRadiusOut = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          0.25,
          curve: Curves.elasticInOut,
        )));

    controller.addListener((){
      print(controller.value);
      if(isDotsAreHide && controller.value >= 0.75 && controller.value ==1){
        setState(() {
          radius = animationRadiusIn.value * initialRadius;

        });
      } else if(controller.value >= 0 && controller.value <= 0.25){
        setState(() {
          radius = animationRadiusOut.value * initialRadius;

        });
      }

    });
*/

    _sendRequest();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _sendRequest() async {
    final response = await widget.requestFn();
    Navigator.of(widget.parentContext).pop(response);
  }

  _setDotColor(double dotIndex) {
    Color color;
    if (dotIndex % 3 == 0) {
      color = dot1Color;
    } else if (dotIndex % 3 == 1) {
      color = dot2Color;
    } else {
      color = dot3Color;
    }
    return color;
  }

  _buildDot(double radius, Color color) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  _buildDots() {
    List<Widget> list = [];
    for (double i = 1; i <= 9; i++) {
      list.add(Transform.translate(
        offset: Offset(radius * cos(i * pi / 4), radius * sin(i * pi / 4)),
        child: _buildDot(7, _setDotColor(i)),
      ));
    }

    return list;
  }

  Widget _buildAnimatedLoading() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: Stack(
          children: <Widget>[
            Center(
              child: RotationTransition(
                turns: animationRotation,
                child: Stack(
                  children: _buildDots(),
                ),
              ),
            ),
            Image.asset(
              'assets/images/swingo-logo.png',
              width: 100,
              height: 100,
            )

          ],
        ),
      ),
    );
    /*return FlareActor(
      'assets/flare/SuccessCheck.flr',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: 'Untitled',
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
      body: _buildAnimatedLoading(),
    );
  }
}
