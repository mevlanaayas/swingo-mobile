import 'package:flutter/material.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/themes.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        home: IndexPage(),
        theme: swTheme,
        debugShowCheckedModeBanner: false,
      );
  }
}
