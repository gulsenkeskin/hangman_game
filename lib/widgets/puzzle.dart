import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  //parametre olarak tahmin edilen kelimeyi alır
  final String guessWord;

  const Puzzle({Key? key, required this.guessWord}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(widget.guessWord.length, (i){
              return _buildSingleCharacterBox(i);
            })
        )
    );
  }

  Widget _buildSingleCharacterBox(int index) {
    return GestureDetector(
      onTap: () {
        _updateSelectedIndex(index);
      },
      child: Container(
        height: 48.0,
        width: 48.0,
        decoration: BoxDecoration(
            color: index == _selectedBoxIndex ? Colors.limeAccent : Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
      ),
    );
  }
}
