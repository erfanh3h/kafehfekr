import 'package:just_audio/just_audio.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_sounds.dart';

enum GameSoundTypes {
  addPeace,
  explode,
  missTurn,
  movePeace,
  removePeace,
  startGame,
  startTurn,
  tap,
  tapButton,
  tapWrong,
  time,
  draw,
  win,
  lose,
  correct,
  dice,
  hit
}

class SoundPlayerComponent extends GlobalController {
  final _actionPlayer = AudioPlayer();
  final _musicPlayer = AudioPlayer();

  bool letPlaySound = false;

  void playGameSound(GameSoundTypes soundType) {
    if (!letPlaySound) {
      return;
    }
    String sound = "";
    switch (soundType) {
      case GameSoundTypes.addPeace:
        sound = AppSounds.addPeace;
        break;
      case GameSoundTypes.explode:
        sound = AppSounds.explode;
        break;
      case GameSoundTypes.missTurn:
        sound = AppSounds.missTurn;
        break;
      case GameSoundTypes.movePeace:
        sound = AppSounds.movePeace;
        break;
      case GameSoundTypes.removePeace:
        sound = AppSounds.removePeace;
        break;
      case GameSoundTypes.startGame:
        sound = AppSounds.startGame;
        break;
      case GameSoundTypes.startTurn:
        sound = AppSounds.startTurn;
        break;
      case GameSoundTypes.tap:
        sound = AppSounds.tap;
        break;
      case GameSoundTypes.tapButton:
        sound = AppSounds.tapButton;
        break;
      case GameSoundTypes.tapWrong:
        sound = AppSounds.tapWrong;
        break;
      case GameSoundTypes.time:
        sound = AppSounds.time;
        break;
      case GameSoundTypes.draw:
        sound = AppSounds.draw;
        break;
      case GameSoundTypes.win:
        sound = AppSounds.win;
        break;
      case GameSoundTypes.lose:
        sound = AppSounds.lose;
        break;
      case GameSoundTypes.correct:
        sound = AppSounds.correct;
        break;
      case GameSoundTypes.dice:
        sound = AppSounds.dice;
        break;
      case GameSoundTypes.hit:
        sound = AppSounds.hit;
        break;
      default:
        sound = AppSounds.addPeace;
    }
    _actionPlayer.setAsset(sound).then((_) {
      _actionPlayer.play();
    });
  }

  changeLetPlayerSound(bool value) {
    letPlaySound = value;
  }

  @override
  void onInit() {
    _actionPlayer.setVolume(.2);
    _musicPlayer.setLoopMode(LoopMode.all);
    super.onInit();
  }

  @override
  void onClose() {
    _actionPlayer.dispose();
    super.onClose();
  }
}
