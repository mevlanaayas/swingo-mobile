import 'package:flutter/material.dart';

class PfAlertDialog extends StatelessWidget {
  const PfAlertDialog({
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
