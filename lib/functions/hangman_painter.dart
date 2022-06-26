import 'package:flutter/material.dart';
import 'package:hangman_game/bloc/game_stage_bloc.dart';

class HangManPainter extends CustomPainter {
  final GameStageBloc _gameStageBloc;
  double _headHeight = 32.0;

  HangManPainter(this._gameStageBloc);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;

    _drawFrame(canvas, size, paint);
    _drawNoose(canvas, size, paint);

    _drawHead(canvas, size, paint);
    _drawBody(canvas, size, paint);
    _drawLeg(canvas, size, paint, Limb.left);
    _drawLeg(canvas, size, paint, Limb.right);
    _drawHand(canvas, size, paint, Limb.left);
    _drawHand(canvas, size, paint, Limb.right);
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

  _drawHead(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.fill;
    var nooseEnd = Offset(size.width / 2, size.height / 5);
    canvas.drawCircle(nooseEnd, _headHeight, paint);
  }

  _drawBody(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.blueAccent;
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);
    var bodyEnd = Offset(size.width / 2, bodyStart.dy + (3 * _headHeight));
    paint.strokeWidth = 8.0;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, (bodyStart.dy + bodyEnd.dy) / 2),
            height: _headHeight * 3,
            width: _headHeight * 2),
        paint);
  }

  _drawLeg(Canvas canvas, Size size, Paint paint, Limb limb) {
    paint.color = Colors.yellowAccent;
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);

    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var legStart = Offset(dxStart, bodyStart.dy + (3 * _headHeight));

    var dxEnd = limb == Limb.left ? size.width / 2 - 32 : size.width / 2 + 32;
    var legEnd = Offset(dxEnd, legStart.dy + (3 * _headHeight));
    paint.strokeWidth = 8.0;
    canvas.drawLine(legStart, legEnd, paint);
  }

  _drawHand(Canvas canvas, Size size, Paint paint, Limb limb) {
    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);

    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var handStart = Offset(dxStart, bodyStart.dy);

    var dx = limb == Limb.left ? size.width / 2 - 64 : size.width / 2 + 64;

    var handEnd = Offset(dx, handStart.dy + (2.5 * _headHeight));
    paint.strokeWidth = 8.0;
    canvas.drawLine(handStart, handEnd, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // we will come back to this later...
    return false;
  }
}

enum Limb { left, right }
