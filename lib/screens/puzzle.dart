import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  //parametre olarak tahmin edilen kelimeyi alır
  final String guessWord;

  const Puzzle({Key? key, required this.guessWord}) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
