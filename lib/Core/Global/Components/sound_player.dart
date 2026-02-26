import 'dart:io';

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
  chat,
}

class SoundPlayerComponent extends BaseController {
  final _actionPlayer = AudioPlayer();
  final _musicPlayer = AudioPlayer();

  bool letPlaySound = true;
  RxBool letPlayMusic = RxBool(true);

  bool isMusicPlaying = false;
  bool isMusicPaused = false;

  void playGameSound(GameSoundTypes soundType) {
    if (!letPlaySound || Platform.isWindows) {
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
      case GameSoundTypes.chat:
        sound = AppSounds.chat;
        break;
    }
    _actionPlayer.setAsset(sound).then((_) {
      _actionPlayer.play();
    });
  }

  void changeLetPlayerSound(bool value, {bool isGame = true}) {
    letPlayMusic.value = value;
    if (!value) {
      try {
        isMusicPlaying = false;
        isMusicPaused = false;
        _musicPlayer.stop();
      } catch (_) {}
    } else {
      startPlayMusic(isGame: isGame);
    }
  }

  Future startPlayMusic({bool isGame = false}) async {
    if (!letPlayMusic.value || Platform.isWindows) {
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
    musicList.shuffle();
    // final playlist = ConcatenatingAudioSource(children: musicList);
    await _musicPlayer.setAudioSources(musicList);
    await _musicPlayer.setLoopMode(LoopMode.all);
    isMusicPlaying = true;
    isMusicPaused = false;
    await _musicPlayer.play();
  }

  Future startPlayQueueMusic() async {
    if (!letPlayMusic.value || Platform.isWindows) {
      return;
    }
    _musicPlayer.setAsset(AppMusics.queueMusic).then((_) {
      _musicPlayer.play();
    });
    await _musicPlayer.setLoopMode(LoopMode.one);
    isMusicPlaying = true;
    isMusicPaused = false;
    await _musicPlayer.play();
  }

  void stopMusic() {
    if (!letPlayMusic.value) {
      return;
    }
    if (isMusicPlaying) {
      isMusicPlaying = false;
      _musicPlayer.stop();
    }
  }

  void pauseMusic() {
    if (!letPlayMusic.value) {
      return;
    }
    if (isMusicPlaying) {
      isMusicPaused = true;
      _musicPlayer.pause();
    }
  }

  void resumeMusic() {
    if (!letPlayMusic.value) {
      return;
    }
    if (isMusicPaused) {
      isMusicPaused = false;
      _musicPlayer.play();
    }
  }

  @override
  void onInit() {
    _actionPlayer.setVolume(.35);
    _musicPlayer.setVolume(.15);
    super.onInit();
  }

  @override
  void onClose() {
    _actionPlayer.dispose();
    _musicPlayer.dispose();
    super.onClose();
  }
}
