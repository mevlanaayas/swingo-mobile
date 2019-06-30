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
      key: 'Make a Payment',
      title: 'Make a Payment',
      description: 'Waiting for Payment',
      completedCondition: 'Payment Passed for On Delivery',
      carrier: false,
      illustration: '',
      url: 'pass_payment',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 2,
      key: 'Check Packet',
      title: 'Check Packet',
      description: 'Please check your box carefully.',
      completedCondition: 'Box Check Passed',
      carrier: true,
      illustration: '',
      url: 'check_box_done',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 3,
      key: 'Request Taking Packet',
      title: 'Request Taking Packet',
      description: 'We will send confirmation code to Sender.',
      completedCondition: 'Packet Taking Code Sent',
      carrier: true,
      illustration: '',
      url: 'ready_for_taking_box',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 4,
      key: 'Confirm Code',
      title: 'Take Packet',
      description: 'Package and Sender are ready to go.',
      completedCondition: 'On Way',
      carrier: true,
      illustration: '',
      url: 'ready_to_travel',
      requiresParam: true,
    ),
    const CheckpointStep(
      id: 5,
      key: 'Request Delivery',
      title: 'Request Delivery',
      description: 'Carrier arrived, send the confirm code.',
      completedCondition: 'Confirm Code Sent',
      carrier: true,
      illustration: '',
      url: 'ready_for_code_confirm',
      requiresParam: false,
    ),
    const CheckpointStep(
      id: 6,
      key: 'Confirm Code',
      title: 'Confirm Code',
      description: 'We sent confirm code to you. Check your inbox.',
      completedCondition: 'Finished',
      carrier: true,
      illustration: '',
      url: 'confirm_confirmation_code',
      requiresParam: true,
    ),
    const CheckpointStep(
      id: 7,
      key: 'Finished',
      title: 'Finished',
      description:
          'We are happy to see yu finished a deal. Always a pleasure to serve you.',
      completedCondition: 'Finished',
      carrier: false,
      illustration: '',
      url: '',
      requiresParam: false,
    ),
  ];

  Widget _buildScreen() {
    Widget result = Text("none");
    steps.forEach((step) {
      if (step.completedCondition == widget.match.status) {
        result = step.requiresParam == true
            ? ParamStepScreen(step: step, matchId: widget.match.id)
            : DefaultStepScreen(step: step, matchId: widget.match.id);
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: _buildScreen(),
        ),
      ),
    );
  }
}
