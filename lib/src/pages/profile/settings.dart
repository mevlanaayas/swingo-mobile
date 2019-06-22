import 'package:flutter/material.dart';
import 'package:swingo/src/pages/profile/painter.dart';
import 'package:swingo/src/theme/style.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: CustomPaint(
          painter: CurvePainter(),
          child: Center(
            child: Text(
              "Blade Runner",
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
