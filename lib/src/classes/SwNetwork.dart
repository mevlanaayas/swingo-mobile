import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/pages/splash.dart';
import 'package:flutter/widgets.dart';

abstract class SwNetwork {
  static void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: secondaryColor,
        content: new Text(message, style: TextStyle(color: primaryColor)),
      ),
    );
  }

  static void sendRequest(BuildContext context, requestFn) {
    // final response = request();
    //Navigator.of(context).pushNamed('/splash', arguments: request);
    Navigator.of(context).push(
        TransparentRoute(builder: (BuildContext context) =>  SplashScreen(requestFn: requestFn))
    );
  }

  showSplashScreen(BuildContext context, request) {
    return () {
      Navigator.of(context).pushNamed('/splash', arguments: request);
    };
  }
}


class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}