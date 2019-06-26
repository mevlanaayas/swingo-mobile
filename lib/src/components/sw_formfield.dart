import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swingo/src/theme/decoration.dart';

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
  final TextEditingController controller;
  final int maxLines;

  SwFormField(
      {this.text,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.onFocused,
      this.onEditingCompleted,
      this.isNumber,
      this.obscureText,
      this.focusNode,
      this.controller,
      this.maxLines});

  @override
  State<StatefulWidget> createState() {
    return SwFormFieldState();
  }
}

class SwFormFieldState extends State<SwFormField> {
  FocusNode focusNode;
  TextEditingController textEditingController;

  void _onEditingCompleted() {
    if (widget.onEditingCompleted != null) {
      widget.onEditingCompleted();
    }
    focusNode.unfocus();
  }

  TextInputType _setKeyboardType() {
    if (widget.isNumber != null && widget.isNumber == true) {
      return TextInputType.number;
    } else if (widget.maxLines != null) {
      return TextInputType.multiline;
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
    textEditingController = (widget.controller != null)
        ? widget.controller
        : TextEditingController();
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
      maxLines: widget.maxLines,
      inputFormatters: _setInputFormatters(),
      obscureText: _setObscureText(),
      focusNode: focusNode,
      controller: textEditingController,
      onEditingComplete:
          widget.onEditingCompleted != null ? _onEditingCompleted : null,
      style: TextStyle(color: secondaryColor),
      decoration: FormFieldDecoration(
        widget.labelText,
        null,
        widget.prefixIcon,
        widget.suffixIcon,
      ),
    );
  }
}
