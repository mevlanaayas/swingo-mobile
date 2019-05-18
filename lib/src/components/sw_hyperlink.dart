import 'package:flutter/material.dart';

class SwHyperlink extends StatelessWidget {
  const SwHyperlink({@required this.onTap, @required this.text});

  final GestureTapCallback onTap;
  final Text text;

  @override
  Widget build(BuildContext context) {
    // TODO: FIXME: not convenient for general usage.
    // we need to make it only gesture detector, instead of SizedBox and Column.
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          height: 40.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text,
            ],
          )),
    );
  }
}
