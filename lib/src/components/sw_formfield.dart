import 'package:flutter/material.dart';

import 'package:swingo/src/theme/style.dart';

class SwFormField extends StatefulWidget{
  final String text;
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final onFocused;

  SwFormField({
    this.text,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onFocused
  });

  @override
  State<StatefulWidget> createState() {
    return SwFormFieldState();
  }
}

class SwFormFieldState extends State<SwFormField>{
  FocusNode focusNode;
  TextEditingController textEditingController = TextEditingController();


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
    textEditingController.text = widget.text; //todo: bunu taşımak lazım hata basıyo
    focusNode.addListener((){
      if(focusNode.hasFocus){
        widget.onFocused(context, focusNode);
      }
    });
    return TextFormField(
      focusNode: focusNode,
      style: TextStyle(color: secondaryColor),
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 1.0)
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: primaryColor),
          prefixIcon: Icon(widget.prefixIcon, color: primaryColor),
          suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon, color: primaryColor) : null
      ),
      controller: textEditingController,
    );
  }
}
