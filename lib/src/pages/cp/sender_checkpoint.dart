import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';

import 'checkpoint_methods.dart';

class SenderCheckpoint extends CheckpointMethods {
  bool isOrderOwner;

  SenderCheckpoint(this.isOrderOwner);

  List<Step> buildSteps(BuildContext context, int currentStepIndex) {
    String userType = ORDER_OWNER_TYPES['SENDER'];
    return [
      this.buildStep(
        matchStatus: MATCH_STATUSES['INITIATED'],
        stepIndex: 0,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['CARRIER_APPROVED'],
        stepIndex: 1,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['WAITING_FOR_PAYMENT'],
        stepIndex: 2,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PAYMENT_PASSED_FOR_ON_ON_DELIVERY'],
        stepIndex: 3,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['BOX_CHECK_PASSED'],
        stepIndex: 4,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PACKET_TAKING_CODE_SENT'],
        stepIndex: 5,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['ON_WAY'],
        stepIndex: 6,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PACKET_DELIVERY_CODE_SENT'],
        stepIndex: 7,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['FINISHED'],
        stepIndex: 8,
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
    ];
  }
}
