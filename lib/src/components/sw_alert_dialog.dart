import 'package:flutter/material.dart';

class SwAlertDialog extends StatelessWidget {
  const SwAlertDialog({
    @required this.title,
    @required this.onPressed,
  });

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        FlatButton(child: Text('Continue'), onPressed: onPressed),
      ],
    );
  }
}
