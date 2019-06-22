import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/profile/bid_details.dart';
import 'package:swingo/src/pages/profile/match_details.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';
import 'package:swingo/src/utils/sliders.dart';

BoxDecoration get _cardItemDecoration => BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 10),
            blurRadius: 10,
            spreadRadius: 0),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(9)),
      color: Colors.white,
    );

class ListItem extends StatefulWidget {
  final Order item;

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
      SlideTopRoute(page: DetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: _cardItemDecoration,
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
      decoration: _cardItemDecoration,
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

class HomeItem extends StatefulWidget {
  final Widget toPage;
  final IconData icon;
  final String text;

  HomeItem({this.toPage, this.icon, this.text});

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  Future<void> _handleTap(BuildContext context) async {
    Navigator.push(
      context,
      SlideRightRoute(page: widget.toPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 0.0,
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => _handleTap(context),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: whiteColor,
                  size: 50.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.text,
                  style: homeItemTextStyle,
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
        decoration: _cardItemDecoration,
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

class MatchItem extends StatefulWidget {
  final SwMatch item;

  const MatchItem({this.item});

  @override
  _MatchItemState createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  Widget _buildHeading(String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                widget.item.purchaser.username == username
                    ? const Icon(
                        FontAwesomeIcons.moneyBillWave,
                        color: secondaryColor,
                        size: 11.0,
                      )
                    : const Icon(
                        FontAwesomeIcons.babyCarriage,
                        color: secondaryColor,
                        size: 11.0,
                      ),
                SizedBox(
                  width: 5.0,
                ),
                widget.item.purchaser.username == username
                    ? Text(
                        "PURCHASING",
                        style: itemBodyDetailContentStyle,
                      )
                    : Text(
                        "CARRYING",
                        style: itemBodyDetailContentStyle,
                      ),
              ],
            ),
            // Text("₺" + widget.item.price.toString(), style: itemPriceContentStyle)
          ],
        ),
        Text("₺" + widget.item.value.toString(), style: itemPriceContentStyle)
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              widget.item.fromAddress,
              style: itemBodyDetailContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Text(
              widget.item.toAddress,
              style: itemBodyDetailContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            const Text(
              "Payment",
              style: itemBodyTextContentStyle,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item.paymentType.toString(),
              style: itemBodyTextContentStyle,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            const Text(
              "Status",
              style: itemBodyTextContentStyle,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              widget.item.status,
              style: itemBodyTextContentStyle,
            ),
          ],
        ),
      ],
    );
  }

  bool isExpanded = false;

  Future<void> _handleTap(BuildContext context, SwMatch item) async {
    Navigator.push(
      context,
      SlideTopRoute(page: MatchDetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: _cardItemDecoration,
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

BoxDecoration rightProfileItemBoxDecoration() {
  return BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
  );
}

BoxDecoration leftProfileItemBoxDecoration() {
  return BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
  );
}

class ProfileItem extends StatefulWidget {
  final Widget toPage;
  final IconData icon;
  final String text;
  final bool right;

  ProfileItem({this.toPage, this.icon, this.text, this.right});

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  Future<void> _handleTap(BuildContext context) async {
    Navigator.push(
      context,
      SlideRightRoute(page: widget.toPage),
    );
  }

  static const double padding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.right == true
          ? rightProfileItemBoxDecoration()
          : leftProfileItemBoxDecoration(),
      child: Material(
        elevation: 0.0,
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => _handleTap(context),
          child: Padding(
            padding: widget.right == true
                ? const EdgeInsets.only(
                    right: padding * 2, top: padding, bottom: padding)
                : const EdgeInsets.only(
                    left: padding * 2, top: padding, bottom: padding),
            child: Row(
              mainAxisAlignment: widget.right
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: widget.right
                  ? [
                      Text(
                        widget.text,
                        style: whiteTextStyle,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        widget.icon,
                        color: whiteColor,
                        size: 30.0,
                      ),
                    ]
                  : [
                      Icon(
                        widget.icon,
                        color: whiteColor,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        widget.text,
                        style: whiteTextStyle,
                      )
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
