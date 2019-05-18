import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

class SwIconButton extends StatelessWidget {
  const SwIconButton({@required this.onPressed, @required this.icon});

  final GestureTapCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}

class SwButton extends StatelessWidget {
  const SwButton(
      {@required this.onPressed, @required this.text, this.iconData});

  final GestureTapCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: swPink900,
      splashColor: swPink600,
      disabledColor: swLivingCoral50,
      elevation: 4.0,
      // TODO: add color palette and theming. arrange fillColor, splashColor etc
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: iconData == null
              ? <Widget>[
                  Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ]
              : <Widget>[
                  Icon(
                    iconData,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
        ),
      ),
      onPressed: onPressed,
      shape: StadiumBorder(),
    );
  }
}
