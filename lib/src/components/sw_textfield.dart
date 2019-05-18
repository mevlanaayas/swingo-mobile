import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

class SwTextField extends StatelessWidget {
  const SwTextField(
      {this.onChanged,
      this.textInputType,
      this.hintText,
      this.labelText,
      this.controller,
      this.errorText,
      this.obscureText});

  final Function onChanged;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AccentColorOverride(
      color: altDarkGrey,
      child: TextField(
        controller: controller,
        style: Theme.of(context).primaryTextTheme.subtitle,
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: textInputType,
        // TextInputType.phone or TextInputType.text
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText,
            errorText: errorText),
      ),
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
