import 'package:flutter/material.dart';
import 'package:hangman_game/bloc/game_stage_bloc.dart';
import 'package:hangman_game/functions/hangman_painter.dart';
import 'package:hangman_game/widgets/character_picker.dart';
import 'package:hangman_game/widgets/puzzle.dart';



class GameStage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameStage();
  }
}

class _GameStage extends State<GameStage> {
   late GameStageBloc _gameStageBloc;

  @override
  void initState() {
    super.initState();
    _gameStageBloc = GameStageBloc();
  }

  @override
  void dispose() {
    // _gameStageBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQd = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red])),
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
                  painter: HangManPainter(_gameStageBloc),
                  size: Size(
                    (270 - 24.0),
                    (mediaQd.height - 24.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: ValueListenableBuilder(
                      valueListenable: _gameStageBloc.curGuessWord,
                      builder: (BuildContext ctxt, String guessWord,  child) {
                        if (guessWord == null || guessWord == '') {
                          return Center(
                              child: RaisedButton(
                                child: Text('Start New Game'),
                                onPressed: () {
                                  _gameStageBloc.createNewGame();
                                },
                              ));
                        }

                        return ValueListenableBuilder(
                            valueListenable: _gameStageBloc.curGameState,
                            builder: (BuildContext ctxt, GameState gameState,
                                 child) {
                              if (gameState == GameState.succeded) {
                                return Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Well done! You got the right answer.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0)),
                                      RaisedButton(
                                        child: Text('Start New Game'),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      )
                                    ]);
                              }

                              if (gameState == GameState.failed) {
                                return Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Oops you failed!',
                                          style: TextStyle(
                                            // color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0)),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'The correct word was: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16.0)),
                                          TextSpan(
                                              text:
                                              _gameStageBloc.curGuessWord.value,
                                              style: TextStyle(
                                                // color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24.0))
                                        ]),
                                      ),
                                      RaisedButton(
                                        child: Text('Start New Game'),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      )
                                    ]);
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Guess the correct district...',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.restore,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          _gameStageBloc.createNewGame();
                                        },
                                      ),
                                    ],
                                  ),
                                  CharacterPicker(
                                    gameStageBloc: _gameStageBloc,
                                  ),
                                  Puzzle(
                                    guessWord: guessWord,
                                    gameStageBloc: _gameStageBloc,
                                  )
                                ],
                              );
                            });
                      },
                    )),
              )
            ],
          )),
    );
  }
}