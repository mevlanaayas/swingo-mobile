import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/welcome/welcome.dart';
import 'package:swingo/src/theme/themes.dart';

class SwApp extends StatefulWidget {
  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swingo',
      routes: {
        '/': (context) => HomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/profile': (context) => ProfileScreen(),
        '/route': (context) => WelcomeScreen(),
        '/orders': (context) => OrdersScreen(),
        '/bids': (context) => BidsScreen(),
        '/create-send-order': (context) => CreateOrdersScreen(),
        '/create-carry-order': (context) => CreateOrdersScreen(),
      },
      theme: swTheme,
    );
  }
}
