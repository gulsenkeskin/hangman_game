import 'package:flutter/material.dart';

class GameStage extends StatefulWidget {
  const GameStage({Key? key}) : super(key: key);

  @override
  State<GameStage> createState() => _GameStageState();
}

class _GameStageState extends State<GameStage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Hangman Game"),),
    );
  }
}
