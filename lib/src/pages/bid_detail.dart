import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text(item),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item),
      ),
    );
  }
}
