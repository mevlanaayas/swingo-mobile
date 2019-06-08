import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';

class DetailScreen extends StatelessWidget {
  final Order item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

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

  Widget _buildPackageDetails() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item.from_city,
              style: itemDetailCityStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Dates",
              style: itemBodyDateContentStyle,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
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
                                    item.created_by.length > 20
                                        ? Text(
                                            item.created_by.substring(0, 20) +
                                                "...",
                                            style: itemUsernameContentStyle,
                                          )
                                        : Text(
                                            item.created_by,
                                            style: itemUsernameContentStyle,
                                          ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    const Icon(FontAwesomeIcons.user, size: 15)
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
                  child: _buildPackageDetails(),
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
                          text: 'MAKE A BID',
                          onPressed: () {
                            print(item.id);
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
