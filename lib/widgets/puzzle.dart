import 'package:flutter/material.dart';
import 'package:hangman_game/bloc/game_stage_bloc.dart';

class Puzzle extends StatefulWidget {
  //parametre olarak tahmin edilen kelimeyi alır
  final String guessWord;

  final GameStageBloc gameStageBloc;


  const Puzzle({Key? key, required this.guessWord, required this.gameStageBloc}) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  //kullanıcının o anda hangi karakteri tahmin etmeye çalıştığını tutar
  int _selectedBoxIndex = 0;

  //herhangi bir kutuya dokunulduğunda selectedBoxIndex güncellenir
  void _updateSelectedIndex(int i) {
    setState(() {
      _selectedBoxIndex = i;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.gameStageBloc.guessedCharacters,
        builder: (BuildContext ctxt,
            AsyncSnapshot<List<String>> guessedLettersSnap) {
          if (!guessedLettersSnap.hasData) return CircularProgressIndicator();

          return Container(
              child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(widget.guessWord.length, (i) {
                    var letter = widget.guessWord[i];
                    var letterGuessedCorrectly = guessedLettersSnap.data?.contains(letter);

                    return _buildSingleCharacterBox(letter, letterGuessedCorrectly!);
                  })));
        });
  }

  Widget _buildSingleCharacterBox(String letter, bool letterGuessedCorrectly) {
    return Container(
      height: 48.0,
      width: 48.0,
      decoration: BoxDecoration(
          color: letterGuessedCorrectly ? Colors.limeAccent : Colors.white,
          borderRadius: BorderRadius.circular(4.0)),
      child: letterGuessedCorrectly
          ? Center(
        child: Text(
          letter,
          style: _guessedCharacterStyle,
          textAlign: TextAlign.center,
        ),
      )
          : null,
    );
  }

  TextStyle _guessedCharacterStyle =
  TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}