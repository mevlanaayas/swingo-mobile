import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

class SwSearch extends StatefulWidget {
  final onSearchChanged;
  final bool hideSearchBar;
  final List<dynamic> list;

  SwSearch({this.onSearchChanged, this.hideSearchBar, this.list});

  @override
  _SwSearchState createState() => _SwSearchState();
}

class _SwSearchState extends State<SwSearch> with SwScreen {
  List<dynamic> list = [];
  TextEditingController _textEditingController = TextEditingController();
  DateTime searchingTextChangedAt;

  @override
  void initState() {
    if (widget.list != null) {
      list = widget.list;
    }
    super.initState();
  }

  void _cleanTextEditing() {
    _textEditingController.clear();
  }

  Widget _buildSearchField(BuildContext context) {
    if (widget.hideSearchBar != null && widget.hideSearchBar == true) {
      return SizedBox();
    }
    return Container(
      child: Center(
        child: TextField(
          style: messageWhiteTextStyle,
          cursorColor: searchFieldColor,
          decoration: SmallFormFieldDecoration(
            null,
            null,
            FontAwesomeIcons.search,
            _textEditingController.text != ''
                ? IconButton(
                    color: searchFieldColor,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      FontAwesomeIcons.timesCircle,
                      color: searchFieldColor,
                    ),
                    onPressed: _cleanTextEditing,
                  )
                : null,
            primaryColor: searchFieldColor,
            secondaryColor: primaryColor,
          ),
          controller: _textEditingController,
          onChanged: (newText) => _onTextChanged(context, newText),
        ),
      ),
    );
  }

  _onTextChanged(BuildContext context, String newText) async {
    DateTime newSearchingTextChangedAt = DateTime.now();

    await setState(() {
      searchingTextChangedAt = newSearchingTextChangedAt;
    });

    Future.delayed(const Duration(milliseconds: 500), () async {
      if (newSearchingTextChangedAt == searchingTextChangedAt) {
        final newList = await widget.onSearchChanged(context, newText) ?? [];
        setState(() {
          list = newList;
        });
      }
    });
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
                        FontAwesomeIcons.solidBuilding,
                        color: primaryColor,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(element.name, style: secondaryColorTextStyle16)
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
    return Scaffold(
      appBar: this.buildAppbar(
        context,
        titleWidget: Builder(
          builder: (BuildContext titleContext) =>
              _buildSearchField(titleContext),
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _buildListItem(context, index, list),
      ),
    );
  }
}
