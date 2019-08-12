import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
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
      resizeToAvoidBottomPadding: true,
      appBar: this.buildAppbar(
        context,
        titleWidget: _buildTitle(context),
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
    if(!userProvider.isLoggedIn){
      Navigator.of(context).pushNamed('/route');
    }
    if(userProvider.isLoggedIn){
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
            Text(
              item.from_city,
              style: itemDetailCityStyle,
            ),
            const Icon(FontAwesomeIcons.chevronRight),
            Text(
              item.to_city,
              style: itemDetailCityStyle,
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
                      "Dates",
                      style: itemBodyDateContentStyle,
                    ),
                  ],
                )
              ],
            ),
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
          children: <Widget>[
            Text(
              "Weight",
              style: packageDetailStyle,
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
          children: <Widget>[
            Text(
              "Size",
              style: packageDetailStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.size,
              style: itemBodyDateContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text(
              "Price",
              style: packageDetailStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.price.toString(),
              style: itemBodyDateContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                item.comments,
                style: itemBodyDateContentStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: primaryColor50,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom + 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text(
                    "TRAVEL DETAILS",
                    style: itemDetailHeadingStyle,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Divider(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildTravelDetails(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text(
                    "PACKAGE DETAILS",
                    style: itemDetailHeadingStyle,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Divider(),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildPackageDetails(context),
              ),
            ),
            userProvider.currentUser.username != item.created_by
                ? Container(
                    child: Column(
                      children: <Widget>[
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SwButton(
                              color: primaryColor,
                              text: 'MAKE A BID',
                              onPressed: () => _onMakeABidPressed(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Row(),
          ],
        ),
      ),
    );
  }
}
