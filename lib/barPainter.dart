import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final int width;
  final int value;
  final int index;

  BarPainter({this.index, this.value, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset((index * width).ceilToDouble(), 0),
        Offset((index * width).ceilToDouble(), value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
