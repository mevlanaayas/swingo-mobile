import 'package:flutter/material.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_page.dart';
import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/pages/checkpoint/checkpoint_methods.dart';
import 'package:swingo/src/pages/checkpoint/sender_checkpoint.dart';
import 'package:swingo/src/pages/checkpoint/carrier_checkpoint.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/helpers.dart';

class CheckpointScreen extends StatelessWidget with SwScreen {
  final String status;
  final String userType;

  CheckpointScreen({
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
          child: Checkpoint(
            status: this.status,
            userType: this.userType,
          ),
        ),
      ),
    );
  }
}

class Checkpoint extends StatefulWidget {
  final String status;
  final String userType;

  Checkpoint({
    this.status,
    this.userType,
  });

  @override
  _CheckpointState createState() => _CheckpointState();
}

class _CheckpointState extends State<Checkpoint> {
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
