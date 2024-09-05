import 'package:just_audio/just_audio.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Resources/app_musics.dart';
import 'package:kafehfekr/Core/Resources/app_sounds.dart';
import 'package:refreshed/refreshed.dart';

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
  hit,
  bell,
  queueFinded,
}

class SoundPlayerComponent extends BaseController {
  final _actionPlayer = AudioPlayer();
  final _musicPlayer = AudioPlayer();

  bool letPlaySound = true;
  RxBool letPlayMusic = RxBool(true);

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
      case GameSoundTypes.bell:
        sound = AppSounds.bell;
        break;
      case GameSoundTypes.queueFinded:
        sound = AppSounds.queueFinded;
        break;
      default:
        sound = AppSounds.addPeace;
    }
    _actionPlayer.setAsset(sound).then((_) {
      _actionPlayer.play();
    });
  }

  changeLetPlayerSound(bool value , {bool isGame = true}) {
    letPlayMusic.value = value;
    if (!value) {
      try {
        _musicPlayer.stop();
      } catch (_) {}
    } else {
      startPlayMusic(isGame: isGame);
    }
  }

  Future startPlayMusic({bool isGame = false}) async {
    if (!letPlayMusic.value) {
      return;
    }
    List<AudioSource> musicList = [];
    if (isGame) {
      for (var music in AppMusics.games) {
        musicList.add(AudioSource.asset(music));
      }
    } else {
      for (var music in AppMusics.themes) {
        musicList.add(AudioSource.asset(music));
      }
    }
    final playlist = ConcatenatingAudioSource(children: musicList);
    await _musicPlayer.setLoopMode(LoopMode.all);
    await _musicPlayer.setShuffleModeEnabled(true);
    await _musicPlayer.setAudioSource(playlist);
    await _musicPlayer.play();
  }

  @override
  void onInit() {
    _actionPlayer.setVolume(.35);
    _musicPlayer.setVolume(.18);
    super.onInit();
  }

  @override
  void onClose() {
    _actionPlayer.dispose();
    _musicPlayer.dispose();
    super.onClose();
  }
}
