import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class MatchesScreen extends StatelessWidget {
  void _pressed(UserStatus a) {
    a.currentUser = new User(id: 1, username: "mevlana");
    a.userLoggedIn = true;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        userProvider.currentUser != null
            ? Text(userProvider.currentUser.username)
            : Text('User yok'),
        Text(userProvider.userLoggedIn.toString()),
        WelcomeButton(
            onPressed: () => _pressed(userProvider),
            background: secondaryColor,
            icon: FontAwesomeIcons.userCheck,
            label: 'Press')
      ],
    )));
  }
}
