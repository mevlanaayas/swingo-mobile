import 'package:flutter/material.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/utils/constans.dart';

class Carriers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListScreen(ORDER_OWNER_TYPES["CARRIER"])
    );
  }
}
