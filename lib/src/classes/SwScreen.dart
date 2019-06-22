import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/style.dart';

abstract class SwScreen {
  Widget buildAppbar(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: FlatButton(
          padding: const EdgeInsets.all(0),
          shape: null,
          onPressed: () => Navigator.pop(context, null),
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: secondaryColor,
          ),
        ));
  }

  void changeFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: secondaryColor,
        content: new Text(message, style: TextStyle(color: primaryColor)),
      ),
    );
  }
}
