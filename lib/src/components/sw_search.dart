import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/decoration.dart';

import 'package:swingo/src/theme/style.dart';

class SwSearch extends StatefulWidget {
  dynamic onSearchChanged;
  bool hideSearchBar;

  SwSearch({this.onSearchChanged, this.hideSearchBar});

  @override
  _SwSearchState createState() => _SwSearchState();
}

class _SwSearchState extends State<SwSearch> {
  String searchingText = '';
  bool isCancelButtonActive = false;
  TextEditingController _textEditingController = TextEditingController();

  void _onBackPressed(context) {
    Navigator.pop(context, null);
  }

  void _cleanTextEditing() {
    _textEditingController.clear();
  }

  Widget _buildBackButton() {
    return ButtonTheme(
      minWidth: 0,
      child: FlatButton(
        splashColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        shape: null,
        onPressed: () => _onBackPressed(context),
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: secondaryColor,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    if (widget.hideSearchBar != null && widget.hideSearchBar == true) {
      return null;
    }
    return Container(
      child: Center(
        child: TextField(
          style: secondaryColorTextStyle,
          cursorColor: primaryColor,
          decoration: SmallFormFieldDecoration(
              null,
              null,
              FontAwesomeIcons.search,
              isCancelButtonActive
                  ? IconButton(
                      color: secondaryColor,
                      splashColor: Colors.transparent,
                      icon: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: secondaryColor,
                      ),
                      onPressed: _cleanTextEditing)
                  : null),
          controller: _textEditingController,
        ),
      ),
    );
  }

  void _onListItemTap(dynamic element) {
    Navigator.pop(context, element);
  }

  Widget _buildListItem(BuildContext context, int index, dynamic list) {
    // en üstten alınabilir
    dynamic element = list[index];
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: CardItemDecoration(),
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _onListItemTap(element),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.city,
                        color: primaryColor,
                        size: 20.0
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(element.name,
                          style: secondaryColorTextStyle16)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.addListener(() {
      if (_textEditingController.text != '') {
        setState(() {
          searchingText = _textEditingController.text;
        });
      }

      if (_textEditingController.text != '' && !isCancelButtonActive) {
        setState(() {
          isCancelButtonActive = true;
        });
      } else if (_textEditingController.text == '' && isCancelButtonActive) {
        setState(() {
          isCancelButtonActive = false;
        });
      }
    });

    dynamic list = widget.onSearchChanged(searchingText);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: primaryColor50,
          title: _buildSearchField(),
          leading: _buildBackButton(),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, index, list)));
  }
}
