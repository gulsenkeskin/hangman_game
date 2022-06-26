import 'package:flutter/material.dart';

class HangManPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;

    _drawFrame(canvas, size, paint);
    _drawNoose(canvas, size, paint);
  }

  _drawNoose(Canvas canvas, Size size, Paint paint) {
    var nooseStart = Offset(size.width / 2, 0);
    var nooseEnd = Offset(size.width / 2, size.height / 5);
    paint.strokeWidth = 8.0;
    canvas.drawLine(nooseStart, nooseEnd, paint);
  }

  _drawFrame(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(Rect.fromLTRB(0, size.height, 12, 0), paint);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width / 2, 12), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // we will come back to this later...
    return false;
  }
}
