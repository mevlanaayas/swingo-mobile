import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/checkpoint/rate.dart';
import 'package:swingo/src/services/checkpoint.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/routes.dart';

class DefaultStepScreen extends StatefulWidget {
  final CheckpointStep step;
  final int matchId;
  final int carrierId;
  final dynamic onSuccess;

  DefaultStepScreen({this.step, this.matchId, this.carrierId, this.onSuccess});

  @override
  _DefaultStepScreenState createState() => _DefaultStepScreenState();
}

class _DefaultStepScreenState extends State<DefaultStepScreen> {
  String result = "";
  bool isSuccessful = false;

  Future<void> _handleRateTap(BuildContext context) async {
    await Navigator.of(context).push(
        TransparentRoute(builder: (BuildContext context) => RateScreen()));
  }

  Widget _buildScreen(int currentUserId, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 8.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: currentUserId == widget.carrierId
            ? <Widget>[
                Text(widget.step.title),
                Text(widget.step.carrierDescription),
                Placeholder(
                  fallbackHeight: 300,
                ),
                widget.step.activatedCondition == 'Finished'
                    ? SwButton(
                        color: secondaryColor,
                        text: 'Rate',
                        onPressed: () {
                          _handleRateTap(context);
                        },
                        iconData: FontAwesomeIcons.star,
                      )
                    : SwButton(
                        color: primaryColor,
                        text: 'Progress',
                        onPressed: () {
                          print("progress");
                        },
                      ),
              ]
            : <Widget>[
                Text(widget.step.title),
                Text(widget.step.senderDescription),
                Placeholder(
                  fallbackHeight: 300,
                ),
                widget.step.activatedCondition == 'Finished'
                    ? SwButton(
                        color: secondaryColor,
                        text: 'Rate',
                        onPressed: () {
                          _handleRateTap(context);
                        },
                        iconData: FontAwesomeIcons.star,
                      )
                    : const Text(
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
      alignment: Alignment.center,
      child: _buildScreen(userProvider.currentUser.id, context),
    );
  }
}
