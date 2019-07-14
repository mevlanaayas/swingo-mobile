import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/profile/bid_details.dart';
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
        Text("₺" + widget.item.price.toString(), style: itemPriceContentStyle)
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
      SlideTopRoute(
          page: Detail(
        item: item,
        orderOwnerType: widget.orderOwnerType,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
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

class BidItem extends StatefulWidget {
  final Bid item;

  const BidItem({this.item});

  @override
  _BidItemState createState() => _BidItemState();
}

class _BidItemState extends State<BidItem> {
  Widget _buildHeading(String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            widget.item.created_by == username
                ? const Icon(
                    FontAwesomeIcons.reply,
                    color: secondaryColor,
                    size: 11.0,
                  )
                : const Icon(
                    FontAwesomeIcons.share,
                    color: secondaryColor,
                    size: 11.0,
                  ),
            SizedBox(
              width: 5.0,
            ),
            widget.item.created_by == username
                ? Text(
                    "OUTGOING",
                    style: itemBodyDetailContentStyle,
                  )
                : Text(
                    "INCOMMING",
                    style: itemBodyDetailContentStyle,
                  ),
          ],
        ),
        // Text("₺" + widget.item.price.toString(), style: itemPriceContentStyle)
      ],
    );
  }

  Widget _buildBody(String username) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  widget.item.transporter != null
                      ? Text(
                          widget.item.transporter.from_city
                              .substring(0, 3)
                              .toUpperCase(),
                          style: itemBodyTextContentStyle,
                        )
                      : Text(
                          widget.item.transceiver.from_city
                              .substring(0, 3)
                              .toUpperCase(),
                          style: itemBodyTextContentStyle,
                        ),
                  /*
                  Text(
                    widget.item.from_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  ),
                   */
                  SizedBox(
                    width: 5.0,
                  ),
                  widget.item.transporter != null
                      ? Text(
                          dateVerboseFormatter
                              .format(widget.item.transporter.from_date),
                          style: itemBodyDateContentStyle,
                        )
                      : Text(
                          dateVerboseFormatter
                              .format(widget.item.transceiver.from_date),
                          style: itemBodyDateContentStyle,
                        ),
                  /*
                  Text(
                    dateVerboseFormatter.format(widget.item.from_date),
                    style: itemBodyDateContentStyle,
                  )

                   */
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
                widget.item.transporter != null
                    ? Text(
                        widget.item.transporter.to_city
                            .substring(0, 3)
                            .toUpperCase(),
                        style: itemBodyTextContentStyle,
                      )
                    : Text(
                        widget.item.transceiver.to_city
                            .substring(0, 3)
                            .toUpperCase(),
                        style: itemBodyTextContentStyle,
                      ),
                SizedBox(
                  width: 5.0,
                ),
                widget.item.transporter != null
                    ? Text(
                        dateVerboseFormatter
                            .format(widget.item.transporter.to_date),
                        style: itemBodyDateContentStyle,
                      )
                    : Text(
                        dateVerboseFormatter
                            .format(widget.item.transceiver.to_date),
                        style: itemBodyDateContentStyle,
                      ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Text(
              "Price",
              style: itemPriceContentStyle,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "₺" + widget.item.price.toString(),
              style: itemPriceContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Icon(
              FontAwesomeIcons.user,
              size: 10.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            widget.item.bidder.username == username
                ? widget.item.transporter != null
                    ? Text(
                        widget.item.transporter.created_by,
                        style: itemBodyDetailContentStyle,
                      )
                    : Text(
                        widget.item.transceiver.created_by,
                        style: itemBodyDetailContentStyle,
                      )
                : Text(
                    widget.item.bidder.username,
                    style: itemBodyDetailContentStyle,
                  ),
          ],
        ),
      ],
    );
  }

  bool isExpanded = false;

  Future<void> _handleTap(BuildContext context, Bid item) async {
    Navigator.push(
      context,
      SlideTopRoute(page: BidDetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
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
                  _buildHeading(userProvider.currentUser.username),
                  const SizedBox(height: 12),
                  _buildBody(userProvider.currentUser.username)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
