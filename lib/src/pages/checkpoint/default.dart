import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/checkpoint.dart';
import 'package:swingo/src/theme/style.dart';

class DefaultStepScreen extends StatefulWidget {
  final CheckpointStep step;
  final int matchId;

  DefaultStepScreen({this.step, this.matchId});

  @override
  _DefaultStepScreenState createState() => _DefaultStepScreenState();
}

class _DefaultStepScreenState extends State<DefaultStepScreen> {
  String result = "";
  bool isSuccessful = false;

  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        Text(widget.step.completedCondition),
        Text(result),
        SwButton(
          color: primaryColor,
          text: 'Progress',
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
