import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = secondaryColor;
    paint.strokeWidth = 5.0;

    canvas.drawLine(
      Offset(0, size.height / 2.0),
      Offset(size.width, size.height / 2.0),
      paint,
    );

    paint.color = primaryColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
      Offset(size.width / 2.0, size.height / 2.0),
      size.width / 2.0,
      paint,
    );

    paint.color = blackColor400;
    Path path = Path();
    path.moveTo(size.width / 3.0, size.height * 3 / 4);
    path.lineTo(size.width / 2, size.height * 5 / 6);
    path.lineTo(size.width * 3 / 4, size.height * 4 / 6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
