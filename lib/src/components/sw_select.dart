import 'package:flutter/material.dart';

import 'package:swingo/src/components/sw_search.dart';

class SwSelect extends StatefulWidget{
  final List<dynamic> list;
  final onChanged;
  final String labelText;
  final Widget prefixIcon;

  SwSelect({this.list, this.onChanged, this.labelText, this.prefixIcon});

  @override
  State<StatefulWidget> createState() {
    return SwSelectState();
  }
}

class SwSelectState extends State<SwSelect>{
  FocusNode focusNode;

  void _navigateToSearh(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwSearch()),
    );
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
    focusNode.addListener((){
      if(focusNode.hasFocus){
        focusNode.unfocus();
        _navigateToSearh();
      }
    });
    return TextFormField(
      focusNode: focusNode,
      decoration: new InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: Icon(Icons.arrow_drop_down)
      ),
    );
  }
}
