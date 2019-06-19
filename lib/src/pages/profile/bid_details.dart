import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';

class BidDetailScreen extends StatelessWidget {
  final Bid item;

  BidDetailScreen({Key key, @required this.item}) : super(key: key);

  Widget _buildTravelDetails(String username) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            item.transporter != null
                ? Text(
                    item.transporter.from_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  )
                : Text(
                    item.transceiver.from_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  ),
            const Icon(FontAwesomeIcons.chevronRight),
            item.transporter != null
                ? Text(
                    item.transporter.to_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  )
                : Text(
                    item.transceiver.to_city.substring(0, 3).toUpperCase(),
                    style: itemBodyTextContentStyle,
                  ),
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
                    item.transporter != null
                        ? Text(
                            dateVerboseFormatter
                                .format(item.transporter.from_date),
                            style: itemBodyDateContentStyle,
                          )
                        : Text(
                            dateVerboseFormatter
                                .format(item.transceiver.from_date),
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
                    item.transporter != null
                        ? Text(
                            dateVerboseFormatter
                                .format(item.transporter.to_date),
                            style: itemBodyDateContentStyle,
                          )
                        : Text(
                            dateVerboseFormatter
                                .format(item.transceiver.to_date),
                            style: itemBodyDateContentStyle,
                          ),
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            const Icon(
              FontAwesomeIcons.user,
              size: 12.0,
            ),
            const SizedBox(
              width: 5.0,
            ),
            const Text(
              "User",
              style: itemUsernameContentStyle,
            ),
            const SizedBox(
              width: 10.0,
            ),
            item.bidder.username == username
                ? item.transporter != null
                    ? Text(
                        item.transporter.created_by,
                        style: itemUsernameContentStyle,
                      )
                    : Text(
                        item.transceiver.created_by,
                        style: itemUsernameContentStyle,
                      )
                : Text(
                    item.bidder.username,
                    style: itemUsernameContentStyle,
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
            item.transporter != null
                ? Text(
                    item.transporter.weight.toString(),
                    style: packageDetailStyle,
                  )
                : Text(
                    item.transceiver.weight.toString(),
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
            item.transporter != null
                ? Text(
                    item.transporter.size.toString(),
                    style: packageDetailStyle,
                  )
                : Text(
                    item.transceiver.size.toString(),
                    style: packageDetailStyle,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: ButtonTheme(
                              minWidth: 0,
                              child: FlatButton(
                                splashColor: Colors.transparent,
                                padding: const EdgeInsets.all(0),
                                shape: null,
                                onPressed: () => Navigator.pop(context, null),
                                child: const Icon(
                                  FontAwesomeIcons.times,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Material(
                              elevation: 0.0,
                              type: MaterialType.transparency,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(9)),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () =>
                                    print("chatroom " + item.created_by),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "LIVE",
                                        style: itemUsernameContentStyle,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Icon(FontAwesomeIcons.comments,
                                          size: 20)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: const Text(
                          "TRAVEL DETAILS",
                          style: itemDetailHeadingStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                        _buildTravelDetails(userProvider.currentUser.username),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: const Text(
                          "PACKAGE DETAILS",
                          style: itemDetailHeadingStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildPackageDetails(context),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SwButton(
                            text: 'ACCEPT',
                            onPressed: () {
                              print("accepted " + item.id.toString());
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          SwButton(
                            text: 'REJECT',
                            onPressed: () {
                              print("accepted " + item.id.toString());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
