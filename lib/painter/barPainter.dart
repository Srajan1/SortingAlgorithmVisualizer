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
      paint.color = Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFBFE1B0);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF99D492);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF74C67A);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF56B870);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF39A96B);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF1D9A6C);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF188977);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF137177);
    } else {
      paint.color = Color(0xFF0E4D64);
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
