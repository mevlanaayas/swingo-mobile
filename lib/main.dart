import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/sw_app.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/welcome/welcome.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserStatus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SwApp(),
        routes: {
          '/loading': (context) => LoadingScreen(),
          '/route': (context) => WelcomeScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/create-send-order': (context) => CreateOrdersScreen(),
          '/create-carry-order': (context) => CreateOrdersScreen(),
        },
      ),
    );
  }
}
