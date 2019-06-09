import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/style.dart';

class BaseProfile extends StatelessWidget {
  final Widget child;
  final String type;

  BaseProfile({this.child, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: ButtonTheme(
                      minWidth: 0,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        padding: const EdgeInsets.all(0),
                        shape: null,
                        onPressed: () => Navigator.pop(context, null),
                        child: const Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    type,
                    style: itemDetailHeadingStyle,
                  )
                ],
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
