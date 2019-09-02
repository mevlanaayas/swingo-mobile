import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/utils/constans.dart';

abstract class CheckpointMethods {
  bool isOrderOwner;

  List<Step> buildSteps(BuildContext context, int currentStepIndex);

  StepState setStateOfStep(int stepIndex, int currentStepIndex) {
    StepState stepState;
    if (stepIndex < currentStepIndex) {
      stepState = StepState.complete;
    } else if (stepIndex == currentStepIndex) {
      stepState = StepState.editing;
    } else {
      stepState = StepState.disabled;
    }

    return stepState;
  }

  Step buildStep({
    MatchStatus matchStatus,
    int stepIndex,
    int currentStepIndex,
    String userType,
    List<Widget>
        actions, // TODO: checkpoint'ten yönetim yapılmak istendiğinde ekle.
  }) {
    String contentText = userType == ORDER_OWNER_TYPES["SENDER"]
        ? matchStatus.senderText
        : matchStatus.carrierText;
    return Step(
      title: Text(matchStatus.status),
      content: Row(
        children: <Widget>[
          Text(contentText),
        ],
      ),
      state: this.setStateOfStep(stepIndex, currentStepIndex),
    );
  }
}
