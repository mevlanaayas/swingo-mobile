import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CheckpointScreen extends StatelessWidget {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.only(top:20),
            child: FlareActor(
              'assets/flare/SuccessCheck.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: loading ? 'loading' : 'success',
            ),
          ),
        )
    );
  }
}
