import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

import 'components.dart';

class SwInputText extends StatelessWidget {
  const SwInputText(
      {this.onChanged,
        this.textInputType,
        this.hintText,
        this.labelText,
        this.controller,
        this.errorText,
        @required this.obscureText});

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

