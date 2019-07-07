import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/checkpoint.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

class ParamStepScreen extends StatefulWidget {
  final CheckpointStep step;
  final int matchId;
  final int carrierId;

  ParamStepScreen({this.step, this.matchId, this.carrierId});

  @override
  _ParamStepScreenState createState() => _ParamStepScreenState();
}

class _ParamStepScreenState extends State<ParamStepScreen> {
  String result = "";

  Widget _buildScreen(int currentUserId) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: currentUserId == widget.carrierId
            ? <Widget>[
                Text(widget.step.title),
                Text(widget.step.carrierDescription),
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
              ]
            : <Widget>[
                Text(widget.step.title),
                Text(widget.step.senderDescription),
                TextField(
                  style: disabledColorTextStyle,
                  cursorColor: primaryColor,
                  decoration: SmallFormFieldDecoration(
                    null,
                    null,
                    FontAwesomeIcons.code,
                    null,
                  ),
                ),
                const Text(
                  "Waiting for Carrier",
                  style: primaryColorTextStyle,
                ),
              ],
      ),
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
      if (data['isSuccessful'] == 'true') {
        result = "Successful";
      } else {
        result = data['msg'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: _buildScreen(userProvider.currentUser.id),
    );
  }
}
