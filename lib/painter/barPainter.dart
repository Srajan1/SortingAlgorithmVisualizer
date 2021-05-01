import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final int width;
  final int value;
  final int index;

  BarPainter({this.index, this.value, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFFcaf0f8);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFade8f4);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF90e0ef);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF48cae4);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF00b4d8);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF0096c7);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF0077b6);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF023e8a);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF03045e);
    } else {
      paint.color = Color(0xFF1d3557);
    }
    // print(width);
    paint.strokeWidth = width.ceilToDouble();
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset((index * width).ceilToDouble(), 0),
        Offset((index * width).ceilToDouble(), value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
