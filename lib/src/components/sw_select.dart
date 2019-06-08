import 'package:flutter/material.dart';

import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/components/sw_search.dart';

class SwSelect extends StatefulWidget{
  final text;
  final List<dynamic> list;
  final String labelText;
  final IconData prefixIcon;
  final onSelected;
  final onSearchChanged;

  SwSelect({
    this.text,
    this.list,
    this.onSelected,
    this.labelText,
    this.prefixIcon,
    this.onSearchChanged
  });

  @override
  State<StatefulWidget> createState() {
    return SwSelectState();
  }
}

class SwSelectState extends State<SwSelect>{
  FocusNode focusNode;
  TextEditingController textEditingController = TextEditingController();

  void _navigateToSearch() async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwSearch(onSearchChanged: widget.onSearchChanged)),
    );

    if(result != null){
      widget.onSelected(result);
    }
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
    textEditingController.text = widget.text;
    focusNode.addListener((){
      if(focusNode.hasFocus){
        focusNode.unfocus();
        _navigateToSearch();
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
          suffixIcon: Icon(Icons.arrow_drop_down, color: primaryColor)
      ),
      controller: textEditingController,
    );
  }
}
