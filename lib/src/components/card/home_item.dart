import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/sliders.dart';

class HomeItem extends StatefulWidget {
  final Widget toPage;
  final IconData icon;
  final String text;

  HomeItem({this.toPage, this.icon, this.text});

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  Future<void> _handleTap(BuildContext context) async {
    Navigator.push(
      context,
      SlideRightRoute(page: widget.toPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 0.0,
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => _handleTap(context),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: whiteColor,
                  size: 50.0,
                ),
                SizedBox(
                  height: 10.0,
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
    );
  }
}
