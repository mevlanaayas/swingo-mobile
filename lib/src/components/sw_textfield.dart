import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

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
    return TextField(
      controller: controller,
      style: inputFieldStyle,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: textInputType,
      // TextInputType.phone or TextInputType.text
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
          errorText: errorText),
    );
  }
}
