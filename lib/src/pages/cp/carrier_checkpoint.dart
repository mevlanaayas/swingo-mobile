import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';

import 'checkpoint_methods.dart';

class CarrierCheckpoint extends CheckpointMethods {
  bool isOrderOwner;

  CarrierCheckpoint(this.isOrderOwner);

  // Step: Receive Packet
  _sendReceivePacketRequest(BuildContext context) {
    // TODO: girilen kodu yolla
  }

  _onSendReceivePacketRequestSuccess(BuildContext context) {}

  _onAcceptReceivePacket(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext newContext) {
        return SwDialog(
          isDismissButtonActive: true,
          isAcceptButtonActive: true,
          dismissButtonText: 'Cancel',
          acceptButtonText: 'Accept',
          contentText:
              'You need to enter code which is given by sender to verify receiving packet.',
          onAcceptTap: _sendReceivePacketRequest(context),
          isInputFieldActive: true,
        );
      },
    );
  }

  List<Step> buildSteps(BuildContext context, int currentStepIndex) {
    return [
      Step(
        title: Text(MATCH_STATUSES['INITIATED']),
        content: Row(),
        state: this.setStateOfStep(0, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['CARRIER_APPROVED']),
        content: Row(),
        state: this.setStateOfStep(1, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['WAITING_FOR_PAYMENT']),
        content: Row(),
        state: this.setStateOfStep(2, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['PAYMENT_PASSED_FOR_ON_ON_DELIVERY']),
        content: Row(),
        state: this.setStateOfStep(3, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['BOX_CHECK_PASSED']),
        content: Row(),
        state: this.setStateOfStep(4, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['PACKET_TAKING_CODE_SENT']),
        content: Row(),
        state: this.setStateOfStep(5, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['ON_WAY']),
        content: Row(),
        state: this.setStateOfStep(6, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['PACKET_DELIVERY_CODE_SENT']),
        content: Row(),
        state: this.setStateOfStep(7, currentStepIndex),
      ),
      Step(
        title: Text(MATCH_STATUSES['FINISHED']),
        content: Row(),
        state: this.setStateOfStep(8, currentStepIndex),
      ),
    ];

    return [
      Step(
        title: Text(this.isOrderOwner ? "Create Order" : "Make a Bid"),
        content: Row(),
        state: this.setStateOfStep(0, currentStepIndex),
      ),
      Step(
        title: Text("Deal With Sender"),
        content: Row(),
        state: this.setStateOfStep(1, currentStepIndex),
      ),
      Step(
        title: Text("Receive Packet"),
        content: Column(
          children: <Widget>[
            Text("Receive packet from sender with unique code."),
            Row(
              children: <Widget>[
                IconButton(
                  color: primaryColor,
                  icon: const Icon(FontAwesomeIcons.times),
                  onPressed: () {},
                ),
                IconButton(
                  color: primaryColor,
                  icon: const Icon(FontAwesomeIcons.check),
                  onPressed: () => _onAcceptReceivePacket(context),
                ),
              ],
            )
          ],
        ),
        state: this.setStateOfStep(2, currentStepIndex),
      ),
    ];
  }
}
