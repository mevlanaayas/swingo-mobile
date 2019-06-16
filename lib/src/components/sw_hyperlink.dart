import 'package:flutter/material.dart';

class SwHyperlink extends StatelessWidget {
  const SwHyperlink(
      {@required this.onTap,
      @required this.color,
      @required this.label,
      @required this.fontSize});

  final GestureTapCallback onTap;
  final Color color;
  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // TODO: FIXME: not convenient for general usage.
    // we need to make it only gesture detector, instead of SizedBox and Column.
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child:  Text(label, style: TextStyle(color: color, fontSize: fontSize))
    ),
    );
  }
}
