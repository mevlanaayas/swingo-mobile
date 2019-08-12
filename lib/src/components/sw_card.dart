import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';
import 'package:swingo/src/utils/sliders.dart';

class ListItem extends StatefulWidget {
  final Order item;
  final String orderOwnerType;

  const ListItem({this.item, this.orderOwnerType});

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
            widget.item.created_by.length > 20
                ? Text(
                    widget.item.created_by.substring(0, 20) + "...",
                    style: itemUsernameContentStyle,
                  )
                : Text(
                    widget.item.created_by,
                    style: itemUsernameContentStyle,
                  ),
          ],
        ),
        Text(
          widget.item.price != null
              ? "₺" + widget.item.price.toString()
              : ' YOU DECIDE!',
          style: itemPriceContentStyle,
        )
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    widget.item.from_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    dateVerboseFormatter.format(widget.item.from_date),
                    style: itemBodyDateContentStyle,
                  )
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black38,
              size: 15.0,
            ),
            Container(
                child: Row(
              children: <Widget>[
                Text(
                  widget.item.to_city.substring(0, 3).toUpperCase(),
                  style: itemBodyTextContentStyle,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  dateVerboseFormatter.format(widget.item.to_date),
                  style: itemBodyDateContentStyle,
                )
              ],
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            widget.item.comments.length > 30
                ? Text(
                    widget.item.comments.substring(0, 30) + "...",
                    style: itemBodyDetailContentStyle,
                  )
                : Text(
                    widget.item.comments,
                    style: itemBodyDetailContentStyle,
                  )
          ],
        ),
      ],
    );
  }

  bool isExpanded = false;

  Future<void> _handleTap(BuildContext context, Order item) async {
    Navigator.push(
      context,
      SlideRightRoute(
          page: Detail(
        item: item,
        orderOwnerType: widget.orderOwnerType,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 2.5, top: 2.5),
      child: Container(
        decoration: CardItemDecoration(),
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

class MenuItem extends StatefulWidget {
  final String toRoute;
  final IconData icon;
  final String text;

  MenuItem({this.toRoute, this.icon, this.text});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  Future<void> _handleTap(BuildContext context, String toRoute) async {
    Navigator.of(context).pushNamed(toRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CardItemDecoration(),
      child: Material(
        elevation: 0.0,
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => _handleTap(context, widget.toRoute),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: secondaryColor,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.text,
                  style: profileCardTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
