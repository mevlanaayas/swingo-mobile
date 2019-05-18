import 'package:flutter/material.dart';
import 'package:swingo/src/models/product.dart';

class HomePage extends StatelessWidget {
  final Category category;

  HomePage({this.category: Category.all});

  @override
  Widget build(BuildContext context) {
    return Text(category.toString());
  }
}
