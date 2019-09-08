import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

class CustomTabIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    double indicatorHeight = configuration.size.height / 10 * 8;
    double indicatorWidth = configuration.size.width / 10 * 8;
    final Rect rect = Offset(
            offset.dx + (configuration.size.width / 2) - indicatorWidth / 2,
            (configuration.size.height / 2) - indicatorHeight / 2) &
        Size(indicatorWidth, indicatorHeight);

    // final Rect rect = offset & configuration.size;

    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(10.0)), paint);
  }
}
