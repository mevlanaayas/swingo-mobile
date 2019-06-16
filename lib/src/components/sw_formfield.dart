import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:swingo/src/theme/style.dart';

class SwFormField extends StatefulWidget {
  final String text;
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final onFocused;
  final onEditingCompleted;
  final bool isNumber;
  final bool obscureText;
  final FocusNode focusNode;

  SwFormField({
    this.text,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onFocused,
    this.onEditingCompleted,
    this.isNumber,
    this.obscureText,
    this.focusNode,
  });

  @override
  State<StatefulWidget> createState() {
    return SwFormFieldState();
  }
}

class SwFormFieldState extends State<SwFormField> {
  FocusNode focusNode;
  TextEditingController textEditingController = TextEditingController();

  void _onEditingCompleted() {
    widget.onEditingCompleted(textEditingController.text);
    focusNode.unfocus();
  }

  TextInputType _setKeyboardType() {
    if (widget.isNumber != null && widget.isNumber == true) {
      return TextInputType.number;
    }
    return null;
  }

  List<WhitelistingTextInputFormatter> _setInputFormatters() {
    if (widget.isNumber != null && widget.isNumber == true) {
      return [
        WhitelistingTextInputFormatter.digitsOnly,
      ];
    }
    return null;
  }

  bool _setObscureText() {
    return (widget.obscureText != null && widget.obscureText == true);
  }

  String _validator(String value) {
    if (widget.isNumber != null && widget.isNumber == true) {
      return _numberValidator(value);
    }
    return null;
  }

  String _numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    focusNode = (widget.focusNode != null) ? widget.focusNode : FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text != null || widget.text != '') {
      textEditingController.text =
          widget.text; //todo: bunu taşımak lazım hata basıyo
    }
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (widget.onFocused != null) {
          widget.onFocused(context, focusNode);
        }
      }
    });
    return TextFormField(
      cursorColor: primaryColor,
      validator: _validator,
      keyboardType: _setKeyboardType(),
      inputFormatters: _setInputFormatters(),
      obscureText: _setObscureText(),
      focusNode: focusNode,
      controller: textEditingController,
      onEditingComplete:
          widget.onEditingCompleted != null ? _onEditingCompleted : null,
      style: TextStyle(color: secondaryColor),
      decoration: new InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 3.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          labelText: widget.labelText,
          labelStyle: labelStyle,
          prefixIcon: Icon(widget.prefixIcon, color: primaryColor),
          suffixIcon: widget.suffixIcon != null
              ? Icon(widget.suffixIcon, color: primaryColor)
              : null),
    );
  }
}
