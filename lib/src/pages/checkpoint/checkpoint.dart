import 'package:flutter/material.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/checkpoint/default.dart';
import 'package:swingo/src/pages/checkpoint/param_required.dart';

class CheckpointScreen extends StatefulWidget {
  final SwMatch match;

  CheckpointScreen({this.match});

  @override
  _CheckpointScreenState createState() => _CheckpointScreenState();
}

class _CheckpointScreenState extends State<CheckpointScreen> {
  final List<CheckpointStep> steps = [
    const CheckpointStep(
      id: 1,
      title: 'Waiting for Payment',
      carrierDescription: 'Waiting for Payment',
      senderDescription: 'Waiting for Payment',
      activatedCondition: 'None',
      carrier: false,
      illustration: '',
      url: 'pass_payment',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 2,
      title: 'Waiting for Carrier to Check an Item',
      carrierDescription: 'Please check the item carefully.',
      senderDescription: 'Carrier is checking an item.',
      activatedCondition: 'Payment Passed for On Delivery',
      carrier: true,
      illustration: '',
      url: 'check_box_done',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 3,
      title: 'Waiting for Carrier to take an item.',
      carrierDescription:
          'Progress, When you ready to take an item, We will send confirmation code to Sender.',
      senderDescription:
          'When Carrier ready to take an item, We will send confirmation code to you.',
      activatedCondition: 'Box Check Passed',
      carrier: true,
      illustration: '',
      url: 'ready_for_taking_box',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 4,
      title: 'Confirm Code',
      carrierDescription: 'Waiting for Item taking confirmation.',
      senderDescription: 'Waiting for Item taking confirmation.',
      activatedCondition: 'Packet Taking Code Sent',
      carrier: true,
      illustration: '',
      url: 'ready_to_travel',
      requiresParam: true,
    ),
    const CheckpointStep(
      id: 5,
      title: 'Request Delivery',
      carrierDescription: 'Progress, When you ready to deliver an item, We will send confirmation code to Receiver.',
      senderDescription: 'We sent confirm code to Receiver.',
      activatedCondition: 'On Way',
      carrier: true,
      illustration: '',
      url: 'ready_for_code_confirm',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 6,
      title: 'Confirm Code',
      carrierDescription:
          'Confirm Code',
      senderDescription: 'Carrier Confirming Code',
      activatedCondition: 'Confirm Code Sent',
      carrier: true,
      illustration: '',
      url: 'confirm_confirmation_code',
      requiresParam: true,
    ),
    const CheckpointStep(
      id: 7,
      title: 'Finished',
      carrierDescription:
          'We are happy to see yu finished a deal. Always a pleasure to serve you.',
      senderDescription:
          'We are happy to see yu finished a deal. Always a pleasure to serve you.',
      activatedCondition: 'Finished',
      carrier: false,
      illustration: '',
      url: '',
      requiresParam: false,
    ),
  ];

  Widget _buildScreen() {
    Widget result = Text("none");
    steps.forEach((step) {
      if (step.activatedCondition == widget.match.status) {
        result = step.requiresParam == true
            ? ParamStepScreen(
                step: step,
                matchId: widget.match.id,
                carrierId: widget.match.carrier.id,
              )
            : DefaultStepScreen(
                step: step,
                matchId: widget.match.id,
                carrierId: widget.match.carrier.id,
              );
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }
}
