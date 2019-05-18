import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

class PfCheckbox extends StatelessWidget {
  const PfCheckbox({@required this.value, @required this.onChanged});

  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: FIXME: not convenient for general usage.
    // we need to make it only gesture detector, instead of SizedBox and Column.
    return Checkbox(
        activeColor: swPink600,
        value: value,
        onChanged: onChanged
    );
  }
}