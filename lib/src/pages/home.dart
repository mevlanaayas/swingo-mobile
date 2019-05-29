import 'package:flutter/material.dart';
import 'package:swingo/src/models/filter.dart';

class HomePage extends StatelessWidget {
  final Filter filter;

  HomePage({this.filter});

  @override
  Widget build(BuildContext context) {
    return Text(filter.toString());
  }
}
