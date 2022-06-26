import 'package:flutter/material.dart';
import 'package:hangman_game/functions/hangman_painter.dart';

class GameStage extends StatefulWidget {
  const GameStage({Key? key}) : super(key: key);

  @override
  State<GameStage> createState() => _GameStageState();
}

class _GameStageState extends State<GameStage> {
  @override
  Widget build(BuildContext context) {
    var mediaQd = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(24.0),
          width: mediaQd.width,
          height: mediaQd.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 270,
                height: mediaQd.height,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: CustomPaint(
                  painter: HangManPainter(),
                  size: Size(
                    (270 - 24.0),
                    (mediaQd.height - 24.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(child: Text("Hangman")),
                ),
              )
            ],
          )),
    );
  }
}
