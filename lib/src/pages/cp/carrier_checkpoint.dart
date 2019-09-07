import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';

import 'checkpoint_methods.dart';

class CarrierCheckpoint extends CheckpointMethods {
  String status;

  CarrierCheckpoint({
    this.status,
  });

  List<Step> buildSteps(BuildContext context, MatchStatus currentMatchStatus) {
    int currentStepIndex = currentMatchStatus.stepIndex;
    String userType = ORDER_OWNER_TYPES['CARRIER'];
    return [
      this.buildStep(
        matchStatus: MATCH_STATUSES['INITIATED'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['CARRIER_APPROVED'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['WAITING_FOR_PAYMENT'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PAYMENT_PASSED_FOR_ON_ON_DELIVERY'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['BOX_CHECK_PASSED'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PACKET_TAKING_CODE_SENT'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['ON_WAY'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['PACKET_DELIVERY_CODE_SENT'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
      this.buildStep(
        matchStatus: MATCH_STATUSES['FINISHED'],
        currentStepIndex: currentStepIndex,
        userType: userType,
      ),
    ];
  }
}
