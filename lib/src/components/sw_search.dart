import 'package:flutter/material.dart';

import 'package:swingo/src/theme/style.dart';

class SwSearch extends StatefulWidget{
  @override
  _SwSearchState createState() => _SwSearchState();
}

class _SwSearchState extends State<SwSearch> {
  bool isCancelButtonActive = false;

  TextEditingController _textEditingController = TextEditingController();

  void _onBackPressed(context){
    Navigator.pop(context, null);
  }

  void _cleanTextEditing(){
    _textEditingController.clear();
  }

  Widget _buildBackButton(){
    return RaisedButton(
        child: Icon(
            Icons.arrow_back
        ),
        onPressed: () => _onBackPressed(context)
    );
  }

  Widget _buildSearchField(){
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: secondaryColor)
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: secondaryColor),
              suffixIcon: isCancelButtonActive ?
              IconButton(
                  icon: Icon(Icons.cancel, color: secondaryColor),
                  onPressed: _cleanTextEditing
              ) : null,
              border: InputBorder.none,
              hintText: 'Enter something to search. :)'
          ),
          controller: _textEditingController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener((){
      if(_textEditingController.text != '' && !isCancelButtonActive){
        setState(() {
          isCancelButtonActive = true;
        });
      } else if (_textEditingController.text == '' && isCancelButtonActive){
        setState(() {
          isCancelButtonActive = false;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        leading: _buildBackButton(),
      ),
    );
  }
}