import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/pages/profile/base.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/sliders.dart';

class MatchDetailScreen extends StatelessWidget {
  final SwMatch item;

  MatchDetailScreen({Key key, @required this.item}) : super(key: key);

  Widget _buildTravelDetails() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              FontAwesomeIcons.share,
              size: 15.0,
            ),
            const SizedBox(
              width: 7.0,
            ),
            Text(
              "Carrying from",
              style: itemBodyTextContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item.order.from_city,
              style: itemDetailCityStyle,
            ),
          ],
        ),
        const Divider(),
        Row(
          children: <Widget>[
            const Icon(
              FontAwesomeIcons.reply,
              size: 15.0,
            ),
            const SizedBox(
              width: 7.0,
            ),
            Text(
              "Carrying to",
              style: itemBodyTextContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item.order.to_city,
              style: itemDetailCityStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactDetails(BuildContext context) {
    return Column(
      children: <Widget>[
        /*
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
         */
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text(
              "Value",
              style: packageDetailStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.value.toString(),
              style: itemBodyDateContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text(
              "Payment Type",
              style: packageDetailStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.paymentType,
              style: itemBodyDateContentStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: <Widget>[
            Text(
              "Status",
              style: packageDetailStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              item.status,
              style: blackTextStyle,
            ),
          ],
        ),
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
            bottom: MediaQuery.of(context).padding.bottom + 5,
          ),
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
                              onTap: () => print(item.created_by),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(FontAwesomeIcons.exchangeAlt,
                                        size: 15),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    item.sender.username ==
                                            userProvider.currentUser.username
                                        ? Text(
                                            item.carrier.username,
                                            style: itemUsernameContentStyle,
                                          )
                                        : Text(
                                            item.sender.username,
                                            style: itemUsernameContentStyle,
                                          ),
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
                  child: _buildTravelDetails(),
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
                        "CONTRACT DETAILS",
                        style: itemDetailHeadingStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildContactDetails(context),
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
                          color: primaryColor,
                          text: 'CHECKPOINT',
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideLeftRoute(
                                page: BaseProfile(
                                  child: CheckpointScreen(match:item),
                                  type: "Track you deal",
                                ),
                              ),
                            );
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
    );
  }
}
