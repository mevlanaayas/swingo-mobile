import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FrontlayerPage extends StatelessWidget {
  const FrontlayerPage({
    @required this.title,
    @required this.child,
    })  : assert(title != null),
          assert(child != null);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}