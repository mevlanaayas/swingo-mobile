import 'package:flutter/material.dart';

import 'package:swingo/src/theme/style.dart';

class SwSearch extends StatefulWidget{
  dynamic onSearchChanged;

  SwSearch({this.onSearchChanged});

  @override
  _SwSearchState createState() => _SwSearchState();
}

class _SwSearchState extends State<SwSearch> {
  String searchingText = '';
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
        color: primaryColor,
        child: Icon(Icons.arrow_back, color: secondaryColor),
        onPressed: () => _onBackPressed(context),
        elevation: 0.0,
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

  void _onListItemTap(dynamic element){
    Navigator.pop(context, element);
  }

  Widget _buildListItem(BuildContext context, int index, dynamic list){ // en üstten alınabilir
    dynamic element = list[index];
    return
      InkWell(
        splashColor: primaryColor,
        onTap: () => _onListItemTap(element),
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.location_city, color: primaryColor,),
              SizedBox(width: 12.0,),
              Text(element.name, style: TextStyle(color: secondaryColor))
            ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener((){
      if(_textEditingController.text != ''){
        setState(() {
          searchingText = _textEditingController.text;
        });
      }

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

    dynamic list = widget.onSearchChanged(searchingText);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: _buildSearchField(),
        leading: _buildBackButton(),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => _buildListItem(context, index, list)
      )
    );
  }
}