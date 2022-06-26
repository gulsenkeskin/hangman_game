import 'package:flutter/material.dart';

class HangManPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;

    //dikdörgen çizme
    canvas.drawRect(Rect.fromLTRB(0, size.height, 12, 0), paint);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, 12), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // we will come back to this later...
    return false;
  }
}