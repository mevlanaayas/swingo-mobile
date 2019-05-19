import 'package:flutter/material.dart';
import 'package:swingo/src/theme/themes.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({Key key, this.child, this.onTap, this.backlayer}) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final backlayer;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();

    void handlePageSliding(){
      this.backlayer.setState((){
        this.backlayer.general = _pageController.page.round(); //TODO: burası değiştirilecek
      });
    }

    _pageController.addListener(handlePageSliding);

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
              style: swTheme.textTheme.subhead,
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
      child: PageView(
        controller: _pageController,
        children: <Widget>[
          createFrontLayer('Page 1'),
          createFrontLayer('Page 2')
        ],
      ),
    );
  }
}
