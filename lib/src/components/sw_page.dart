import 'package:flutter/material.dart';

class SwPage extends StatelessWidget{
  final Widget child;
  final AssetImage backgroundImage;

  SwPage({this.child, this.backgroundImage});

  _setBackgroundImage(){
    return backgroundImage != null ?
    backgroundImage : new AssetImage('assets/images/swingo-background.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
              image: _setBackgroundImage(),
              fit: BoxFit.cover
          )
        ),
        child: child
    );
  }
}