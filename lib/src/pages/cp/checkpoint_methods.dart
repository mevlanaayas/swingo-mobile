import 'package:flutter/material.dart';

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

}