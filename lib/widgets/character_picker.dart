import 'package:flutter/material.dart';

class CharacterPicker extends StatefulWidget {
  const CharacterPicker({Key? key}) : super(key: key);

  @override
  State<CharacterPicker> createState() => _CharacterPickerState();
}

class _CharacterPickerState extends State<CharacterPicker> {
  var _alphabets = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z';

  late List<String> _guessedLetters;

  @override
  void initState() {
    super.initState();
    _guessedLetters = [];
  }

  @override
  Widget build(BuildContext context) {
    var alphabetArr = _alphabets.split(',');
    return Container(
        child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(alphabetArr.length, (i){
              var letter = alphabetArr[i];
              return _buildSingleCharacter(letter);
            })
        )
    );
  }

  Widget _buildSingleCharacter(String letter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _guessedLetters.add(letter);
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
            color: _guessedLetters.contains(letter)? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Center(child: Text(letter)),
      ),
    );
  }
}
