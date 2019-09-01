import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_page.dart';
import 'package:swingo/src/pages/cp/sender_checkpoint.dart';
import 'package:swingo/src/theme/style.dart';

import 'carrier_checkpoint.dart';
import 'checkpoint_methods.dart';

class CpScaff extends StatelessWidget with SwScreen {
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
          child: Cp(),
        ),
      ),
    );
  }
}

class Cp extends StatefulWidget {
  @override
  _CpState createState() => _CpState();
}

class _CpState extends State<Cp> {
  int currentCheckpointStatus = 0;
  int currentStepIndex = 2;
  CheckpointMethods checkpointMethods;

  @override
  void initState() {
    bool isSender = false;
    bool isOrderOwner = true;
    if (isSender) {
      checkpointMethods = SenderCheckpoint(isOrderOwner);
    } else {
      checkpointMethods = CarrierCheckpoint(isOrderOwner);
    }
    super.initState();
  }

  List<Step> _buildSteps(BuildContext context) {
    return checkpointMethods.buildSteps(context, this.currentStepIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: _buildSteps(context),
      type: StepperType.vertical,
      currentStep: this.currentStepIndex,
      onStepTapped: (index) {
        setState(() {
          // currentStepIndex = index;
        });
      },
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row();
      },
    );
  }
}
