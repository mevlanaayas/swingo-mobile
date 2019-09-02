import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

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
  const SwButton({
    @required this.onPressed,
    @required this.text,
    this.iconData,
    this.fillParent,
    this.color,
    this.size,
    this.noPadding,
  });

  final GestureTapCallback onPressed;
  final String text;
  final IconData iconData;
  final bool fillParent;
  final Color color;
  final bool noPadding;

  // TODO: create new component as small button
  final double size;

  double _setWidth(BuildContext context) {
    if (this.fillParent != null && this.fillParent == true) {
      return MediaQuery.of(context).size.width;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _setWidth(context),
      child: RaisedButton(
        color: color,
        splashColor: primaryColor,
        disabledColor: secondaryColor,
        elevation: 1.0,
        // TODO: add color palette and theming. arrange fillColor, splashColor etc
        child: Padding(
          padding: this.noPadding != null && this.noPadding == true
              ? EdgeInsets.all(0)
              : (size == null
                  ? EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0)
                  : size <= 320
                      ? EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0)
                      : EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: iconData == null
                ? <Widget>[
                    Text(
                      text,
                      style: buttonTextStyle,
                    ),
                  ]
                : <Widget>[
                    Icon(
                      iconData,
                      color: buttonTextStyle.color,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      text,
                      style: buttonTextStyle,
                    ),
                  ],
          ),
        ),
        onPressed: onPressed,
        shape: StadiumBorder(),
      ),
    );
  }
}
