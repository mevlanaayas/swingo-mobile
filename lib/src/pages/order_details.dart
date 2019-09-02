import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';
import 'package:swingo/src/pages/make_a_bid.dart';

class Detail extends StatelessWidget with SwScreen {
  final Order item;
  final String orderOwnerType;

  Detail({
    Key key,
    @required this.item,
    @required this.orderOwnerType,
  }) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Details',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Material(
            elevation: 0.0,
            type: MaterialType.transparency,
            borderRadius: const BorderRadius.all(Radius.circular(9)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => print(item.created_by),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: userProvider.currentUser.username != item.created_by
                    ? Row(
                        children: <Widget>[
                          item.created_by.length > 20
                              ? Text(
                                  item.created_by.substring(0, 20) + "...",
                                  style: itemUsernameContentStyle,
                                )
                              : Text(
                                  item.created_by,
                                  style: itemUsernameContentStyle,
                                ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Icon(
                            FontAwesomeIcons.user,
                            size: 15,
                            color: primaryColor,
                          )
                        ],
                      )
                    : null,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: this.buildAppbar(
        context,
        // titleWidget: _buildTitle(context),
        title: 'Order Details',
      ),
      body: DetailScreen(
        item: this.item,
        orderOwnerType: this.orderOwnerType,
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Order item;
  final String orderOwnerType;

  DetailScreen({
    Key key,
    @required this.item,
    @required this.orderOwnerType,
  }) : super(key: key);

  _onMakeABidPressed(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    if (!userProvider.isLoggedIn) {
      Navigator.of(context).pushNamed('/route');
    }
    if (userProvider.isLoggedIn) {
      return showDialog(
        context: context,
        builder: (BuildContext newContext) {
          return MakeABid(
            orderOwnerType: this.orderOwnerType,
            order: this.item,
            onRequestError: _onMakeABidRequestError(context),
          );
        },
      );
    }
  }

  _onMakeABidRequestError(BuildContext context) {
    return (responseData) {
      SwScreen.showSnackBar(context, 'Failed');
    };
  }

  Widget _buildTravelDetails() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                item.from_city,
                style: itemDetailCityStyle,
              ),
            ),
            const Icon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey,
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.to_city,
                style: itemDetailCityStyle,
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      dateVerboseFormatter.format(item.from_date),
                      style: itemBodyDateContentStyle,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                      "~",
                      style: itemBodyDateContentStyle,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      dateVerboseFormatter.format(item.to_date),
                      style: itemBodyDateContentStyle,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPackageDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Weight",
              style: packageDetailHeaderStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.weight.toString(),
              style: packageDetailStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Size",
              style: packageDetailHeaderStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.size,
              style: packageDetailStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Price",
              style: packageDetailHeaderStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.price != null ? "₺" + item.price.toString() : ' YOU DECIDE!',
              style: packageDetailStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                item.comments,
                style: packageDetailStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(String title, Widget content) {
    return Padding(
      padding: cardListMargin,
      child: Container(
        decoration: CardItemDecoration(),
        margin: cardMargin,
        child: Padding(
          padding: cardPadding,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: blackItemDetailHeadingStyle,
                ),
              ),
              Divider(),
              content
            ],
          ),
        ),
      ),
    );
  }

  _buildMakeABidButton(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    if (userProvider.currentUser.username == item.created_by) {
      return Row();
    }
    return Flexible(
      flex: 1,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwButton(
              color: primaryColor,
              text: 'MAKE A BID',
              onPressed: () => _onMakeABidPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: primaryColor50,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: Column(
          children: <Widget>[
            _buildCard("TRAVEL DETAILS", _buildTravelDetails()),
            _buildCard("PACKET DETAILS", _buildPackageDetails(context)),
            _buildMakeABidButton(context)
          ],
        ),
      ),
    );
  }
}
