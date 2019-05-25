import 'package:flutter/material.dart';
import 'package:swingo/src/pages/frontlayer.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({Key key, this.children, this.onTap, this.tabController}) : super(key: key);

  final VoidCallback onTap;
  final List<FrontlayerPage> children;
  final tabController;

  @override
  Widget build(BuildContext context) {
    Widget _buildFrontLayer(FrontlayerPage frontlayerPage, BuildContext context){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 15.0),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Text(
              frontlayerPage.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.0),
          Divider(),
          Expanded(
            child: frontlayerPage.child,
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
        _buildFrontLayer(children[0], context),
        _buildFrontLayer(children[1], context)
      ],
      controller: tabController)
    );
  }
}
