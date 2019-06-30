import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/checkpoint.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

class ParamStepScreen extends StatefulWidget {
  final CheckpointStep step;
  final int matchId;

  ParamStepScreen({this.step, this.matchId});

  @override
  _ParamStepScreenState createState() => _ParamStepScreenState();
}

class _ParamStepScreenState extends State<ParamStepScreen> {
  String result = "";
  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        Text(result),
        Text(widget.step.completedCondition),
        TextField(
          style: secondaryColorTextStyle,
          cursorColor: primaryColor,
          decoration: SmallFormFieldDecoration(
            null,
            null,
            FontAwesomeIcons.code,
            null,
          ),
        ),
        SwButton(
          color: primaryColor,
          text: 'Confirm',
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
      url: widget.step.url,
      onSuccess: _onRequestSuccess,
    );
  }

  _onRequestSuccess(LinkedHashMap<String, dynamic> data) {
    setState(() {
      if(data['isSuccessful'] == 'true') {
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
          padding: EdgeInsets.only(top: 20),
          child: _buildScreen(),
        ),
      ),
    );
  }
}
