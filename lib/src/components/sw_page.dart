import 'package:flutter/material.dart';

class SwPage extends StatelessWidget{
  final Widget appbar;
  final Widget body;

  SwPage({this.appbar, this.body});

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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appbar,
          body: body,
        ),
    );
  }
}