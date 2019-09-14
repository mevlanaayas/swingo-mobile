import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoadingScreen extends StatefulWidget {
  final requestFn;
  final parentContext;

  LoadingScreen({this.requestFn, this.parentContext});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    _sendRequest();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _sendRequest() async {
    final response = await widget.requestFn();
    Navigator.of(widget.parentContext).pop(response);
  }

  Widget _buildAnimatedLoading() {
    return FlareActor(
      'assets/flare/SuccessCheck.flr',
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: 'Untitled',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
      body: _buildAnimatedLoading(),
    );
  }
}
