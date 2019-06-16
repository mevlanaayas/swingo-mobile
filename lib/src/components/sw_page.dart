import 'package:flutter/material.dart';

class SwPage extends StatelessWidget{
  final Widget child;

  SwPage({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
          image: new AssetImage('assets/images/swingo-background.png'),
          fit: BoxFit.cover
          )
        ),
        child: child
    );
  }
}