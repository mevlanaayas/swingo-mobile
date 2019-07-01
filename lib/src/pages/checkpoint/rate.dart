import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/services/checkpoint.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

class RateScreen extends StatefulWidget {
  final int matchId;

  RateScreen({this.matchId});

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String result = "";

  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        TextField(
          style: secondaryColorTextStyle,
          cursorColor: primaryColor,
          decoration: SmallFormFieldDecoration(
            null,
            null,
            FontAwesomeIcons.star,
            null,
          ),
        ),
        SwButton(
          color: primaryColor,
          text: 'Rate',
          onPressed: () {
            onTap();
          },
        ),
      ],
    );
  }

  void onTap() {
    print("tapped");
    // send request to step.url with matchId
    CheckpointService.callFunction(
      context,
      matchId: widget.matchId,
      url: 'rate_sender', // or rate_carrier
      onSuccess: _onRequestSuccess,
    );
  }

  _onRequestSuccess(LinkedHashMap<String, dynamic> data) {
    setState(() {
      if (data['isSuccessful'] == 'true') {
        result = "Successful";
      } else {
        result = data['msg'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: _buildScreen(),
        ),
      ),
    );
  }
}
