import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/style.dart';

class ListItem extends StatefulWidget {
  final String item;

  const ListItem({this.item});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Widget _buildHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              FontAwesomeIcons.user,
              color: secondaryColor,
              size: 11.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item,
              style: itemUsernameContentStyle,
            ),
          ],
        ),
        Text("Price", style: itemPriceContentStyle)
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "frC",
              style: itemBodyTextContentStyle,
            ),
            Text(
              "frD",
              style: itemBodyDateContentStyle,
            ),
            Text(
              "icon-dizayn",
              style: itemBodyTextContentStyle,
            ),
            Text(
              "toC",
              style: itemBodyTextContentStyle,
            ),
            Text(
              "toD",
              style: itemBodyDateContentStyle,
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Text(
              "Details",
              style: itemBodyDetailContentStyle,
            )
          ],
        ),
      ],
    );
  }

  bool isExpanded = false;

  BoxDecoration get listItemDecoration => BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 0),
        ],
        // border: isExpanded ? Border.all(color: primaryColor) : null,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        color: Colors.white,
      );

  Future<void> _handleTap(BuildContext context, String item) async {
    Navigator.push(
      context,
      SlideTopRoute(page: DetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: listItemDecoration,
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _handleTap(context, widget.item),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeading(),
                  const SizedBox(height: 12),
                  _buildBody()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// from https://github.com/divyanshub024/Flutter-page-route-transition
class SlideTopRoute extends PageRouteBuilder {
  final Widget page;

  SlideTopRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}
