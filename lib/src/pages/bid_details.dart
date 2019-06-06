import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class DetailScreen extends StatelessWidget {
  final Order item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

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
            item.created_by.length > 20
                ? Text(
                    item.created_by.substring(0, 20) + "...",
                    style: itemUsernameContentStyle,
                  )
                : Text(
                    item.created_by,
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
                  children: <Widget>[
                    Row(
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
                      ],
                    ),
                    const Divider(),
                    Text("TRAVEL DETAILS"),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      _buildHeading(),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      _buildBody()
                    ],
                  ),
                ),
              ),
              Container(
                  child: Column(
                children: <Widget>[const Divider(), Text("PACKAGE DETAILS")],
              )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      _buildHeading(),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      _buildBody()
                    ],
                  ),
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
                            print("hi");
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
