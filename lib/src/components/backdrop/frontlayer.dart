import 'package:flutter/material.dart';
import 'package:swingo/src/theme/themes.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({Key key, this.child, this.onTap, this.tabController}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final tabController;

  @override
  Widget build(BuildContext context) {
    Widget createFrontLayer(text){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 15.0),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.0),
          Divider(),
          Expanded(
            child: child,
          ),
        ],
      );
    }

    return Material(
      color: Colors.white,
      elevation: 40.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      child: TabBarView(children: [
        createFrontLayer('Send'),
        createFrontLayer('Carry')
      ],
      controller: tabController)
    );
  }
}
