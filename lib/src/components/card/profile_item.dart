import 'package:flutter/material.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/sliders.dart';
import 'package:swingo/src/utils/routes.dart';
import 'package:swingo/src/pages/pages.dart';

class ProfileItem extends StatefulWidget {
  final Widget toPage;
  final IconData icon;
  final String text;
  final bool right;
  final handleTap;

  ProfileItem({this.toPage, this.icon, this.text, this.right, this.handleTap});

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  Future<void> _handleTap(BuildContext context) async {
    Navigator.push(
      context,
      SlideRightRoute(page: widget.toPage),
    );
  }

  static const double padding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.right == true
          ? const EdgeInsets.only(right: padding * 2)
          : const EdgeInsets.only(left: padding * 2),
      child: Container(
        decoration: widget.right == true
            ? ProfileItemBoxDecoration()
            : ProfileItemBoxDecoration(),
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => widget.handleTap != null ? widget.handleTap(context) : _handleTap(context),
            child: Padding(
              padding: widget.right == true
                  ? const EdgeInsets.only(
                      right: padding * 2, top: padding, bottom: padding)
                  : const EdgeInsets.only(
                      left: padding * 2, top: padding, bottom: padding),
              child: Row(
                mainAxisAlignment: widget.right
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: widget.right
                    ? [
                        Text(
                          widget.text,
                          style: blackTextStyle,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          widget.icon,
                          color: secondaryColor,
                          size: 30.0,
                        ),
                      ]
                    : [
                        Icon(
                          widget.icon,
                          color: secondaryColor,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.text,
                          style: blackTextStyle,
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
