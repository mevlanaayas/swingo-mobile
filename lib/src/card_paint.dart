import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';

class CornerPainter extends CustomPainter {
  final String orderType;

  CornerPainter({
    this.orderType,
  });

  Color _getColor() {
    return this.orderType == ORDER_OWNER_TYPES['SENDER']
        ? senderCardColor
        : carrierCardColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = _getColor();

    // create a path
    var path = Path();
    double cornerLength = size.width / 8;
    path.moveTo(size.width - cornerLength, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerLength);

    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
