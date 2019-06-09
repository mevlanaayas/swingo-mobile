import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:swingo/src/theme/style.dart';

class SwFormField extends StatefulWidget{
  final String text;
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final onFocused;
  final onEditingCompleted;
  final bool isNumber;

  SwFormField({
    this.text,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onFocused,
    this.onEditingCompleted,
    this.isNumber
  });

  @override
  State<StatefulWidget> createState() {
    return SwFormFieldState();
  }
}

class SwFormFieldState extends State<SwFormField>{
  FocusNode focusNode;
  TextEditingController textEditingController = TextEditingController();


  void _onEditingCompleted(){
    widget.onEditingCompleted(textEditingController.text);
    focusNode.unfocus();
  }

  TextInputType _setKeyboardType(){
    if(widget.isNumber != null && widget.isNumber == true){
      return TextInputType.number;
    }
    return null;
  }

  List<WhitelistingTextInputFormatter> _setInputFormatters(){
    if(widget.isNumber != null && widget.isNumber == true){
      return [
        WhitelistingTextInputFormatter.digitsOnly,
      ];
    }
    return null;
  }

  String _validator(String value){
    if(widget.isNumber != null && widget.isNumber == true){
      return _numberValidator(value);
    }
    return null;
  }

  String _numberValidator(String value) {
    if(value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if(n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.text != null || widget.text != ''){
      textEditingController.text = widget.text; //todo: bunu taşımak lazım hata basıyo
    }
    focusNode.addListener((){
      if(focusNode.hasFocus){
        if(widget.onFocused != null){
          widget.onFocused(context, focusNode);
        }
      }
    });
    return TextFormField(
      validator: _validator,
      keyboardType: _setKeyboardType(),
      inputFormatters: _setInputFormatters(),
      focusNode: focusNode,
      controller: textEditingController,
      onEditingComplete: widget.onEditingCompleted != null ? _onEditingCompleted : null,
      style: TextStyle(color: secondaryColor),
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 1.0)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 1.0)
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: primaryColor),
          prefixIcon: Icon(widget.prefixIcon, color: primaryColor),
          suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon, color: primaryColor) : null
      ),
    );
  }
}
