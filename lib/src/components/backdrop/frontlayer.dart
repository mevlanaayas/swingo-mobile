import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swingo/src/models/product.dart';
import 'package:swingo/src/pages/signin.dart';
import 'package:swingo/src/theme/themes.dart';


// TODO: Add _FrontLayer class (104)
class FrontLayer extends StatelessWidget {
  // TODO: Add on-tap callback (104)
  const FrontLayer({Key key, this.child, this.onTap}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 40.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TODO: Add a GestureDetector (104)
          SizedBox(height: 15),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Text(
              "Explore",
              style: swTheme.textTheme.subhead,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
// TODO: Add _BackdropTitle class (104)
