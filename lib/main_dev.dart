import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/sw_app.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/welcome/welcome.dart';
import 'package:swingo/src/theme/style.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppConfig(
      apiBaseUrl: "http://localhost:8000/swingo",
      chatUrl: "http://localhost:3000/",
      child: ChangeNotifierProvider(
        builder: (context) {
          UserStatus userStatus = UserStatus();
          userStatus.init();
          return userStatus;
        },
        child: MaterialApp(
          theme: ThemeData.light().copyWith(splashColor: pageBackgroundColor),
          debugShowCheckedModeBanner: false,
          home: SwApp(),
          routes: {
            '/loading': (context) => LoadingScreen(),
            '/route': (context) => WelcomeScreen(),
            '/signin': (context) => SignInScreen(),
            '/signup': (context) => SignUpScreen(),
            '/create-send-order': (context) => CreateOrders("Send"),
            '/create-carry-order': (context) => CreateOrders("Carry"),
          },
        ),
      ),
    );
  }
}
