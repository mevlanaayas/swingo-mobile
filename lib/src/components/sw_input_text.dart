import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

class SwInputText extends StatelessWidget {
  const SwInputText(
      {this.onChanged,
      this.textInputType,
      this.hintText,
      this.labelText,
      this.controller,
      this.errorText,
      this.faIcon,
      @required this.obscureText,
      @required this.autoFocus,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted});

  final Function onChanged;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData faIcon;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      controller: controller,
      style: inputFieldStyle,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: textInputType,
      // TextInputType.phone or TextInputType.text
      decoration: faIcon != null
          ? InputDecoration(
              prefixIcon: new Icon(faIcon),
              border: OutlineInputBorder(),
              hintText: hintText,
              labelText: labelText,
              errorText: errorText)
          : InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintText,
              labelText: labelText,
              errorText: errorText),
    );
  }
}
