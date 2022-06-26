import 'package:flutter/widgets.dart';
import 'package:hangman_game/data/guess_word_helper.dart';
import 'package:rxdart/rxdart.dart';

class GameStageBloc {

  var _guessedCharactersController = BehaviorSubject<List<String>>();
  Stream<List<String>> get guessedCharacters => _guessedCharactersController.stream;

  ValueNotifier<GameState> curGameState = ValueNotifier<GameState>(GameState.idle);
  //oyuncu tarafından tanmin edilen kelimeler
  ValueNotifier<String> curGuessWord = ValueNotifier<String>('');

  //kaybolan vücut kısımlarını tahmin etmek için
  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>([]);


  //Önceki çalıştırmadan oluşturulan tüm oyun verilerini temizler ve yeni bir oyun için yeni bir kelime oluşturur.

  void createNewGame() {
    curGameState.value = GameState.running;
    lostParts.value.clear();
    var guessWord = GuessWordHelper().generateRandomWord();
    curGuessWord.value = guessWord;
    _guessedCharactersController.sink.add([]);
  }


  //kelimenin doğru tahmin edilip edilmediğini bulma fonksiyonu
  void _concludeGameOnWordGuessedCorrectly(List<String> guessedCharacters) {
    //check if user identified all correct words
    var allValuesIdentified = true;
    var characters = curGuessWord.value.split('');
    characters.forEach((letter) {
      if(!guessedCharacters.contains(letter)) {
        allValuesIdentified = false;
        return;
      }
    });

    if(allValuesIdentified) {
      curGameState.value = GameState.succeded;
    }
  }

  //kullanıcı tarafından tahmin edilen karakterlerin listesini güncelleme fonksiyonu
  void updateGuessedCharacter(List<String> updatedGuessedCharacters) {
    _guessedCharactersController.sink.add(updatedGuessedCharacters);
    _concludeGameOnWordGuessedCorrectly(updatedGuessedCharacters);
  }


  //kaldırılan vücut parçalarını izleme fonksiyonu
  void updateLostBodyParts() {
    print('removing ');
    if(!lostParts.value.contains(BodyPart.head)) {
      print('head...');
      lostParts.value.add(BodyPart.head);
      return;
    }

    if(!lostParts.value.contains(BodyPart.body)) {
      print('body...');
      lostParts.value.add(BodyPart.body);
      return;
    }

    if(!lostParts.value.contains(BodyPart.leftLeg)) {
      print('left leg...');
      lostParts.value.add(BodyPart.leftLeg);
      return;
    }

    if(!lostParts.value.contains(BodyPart.rightLeg)) {
      print('right left...');
      lostParts.value.add(BodyPart.rightLeg);
      return;
    }

    if(!lostParts.value.contains(BodyPart.leftHand)) {
      print('left hand...');
      lostParts.value.add(BodyPart.leftHand);
      return;
    }

    if(!lostParts.value.contains(BodyPart.rightHand)) {
      print('right hand...');
      lostParts.value.add(BodyPart.rightHand);

      // player has lost all body parts.
      curGameState.value = GameState.failed;
      return;
    }
  }

}
enum GameState {
  idle,
  running,
  failed,
  succeded
}

enum BodyPart {
  head,
  body,
  leftLeg,
  rightLeg,
  leftHand,
  rightHand
}