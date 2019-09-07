import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_page.dart';
import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/pages/cp/sender_checkpoint.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/helpers.dart';

import 'carrier_checkpoint.dart';
import 'checkpoint_methods.dart';

class CpScaff extends StatelessWidget with SwScreen {
  String status;
  String userType;

  CpScaff({
    this.status,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return SwPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: this.buildAppbar(
          context,
          title: "Checkpoint",
        ),
        body: SafeArea(
          child: Cp(
            status: this.status,
            userType: this.userType,
          ),
        ),
      ),
    );
  }
}

class Cp extends StatefulWidget {
  String status;
  String userType;

  Cp({
    this.status,
    this.userType,
  });

  @override
  _CpState createState() => _CpState();
}

class _CpState extends State<Cp> {
  MatchStatus _currentMatchStatus;
  CheckpointMethods checkpointMethods;

  @override
  void initState() {
    String statusKey = getStatusKey(widget.status);
    _currentMatchStatus = MATCH_STATUSES[statusKey];
    if (isSender(widget.userType)) {
      checkpointMethods = SenderCheckpoint(status: widget.status);
    } else {
      checkpointMethods = CarrierCheckpoint(status: widget.status);
    }
    super.initState();
  }

  List<Step> _buildSteps(BuildContext context) {
    return checkpointMethods.buildSteps(context, _currentMatchStatus);
  }

  @override
  Widget build(BuildContext context) {
    print("*****");
    print(_currentMatchStatus.stepIndex);
    return Stepper(
      steps: _buildSteps(context),
      type: StepperType.vertical,
      currentStep: _currentMatchStatus.stepIndex,
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row();
      },
    );
  }
}
