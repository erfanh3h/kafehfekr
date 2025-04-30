// import 'dart:math';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:kafehfekr/Core/Base/base_controller.dart';
// import 'package:kafehfekr/Core/Resources/app_musics.dart';
// import 'package:kafehfekr/Core/Resources/app_sounds.dart';
// import 'package:refreshed/refreshed.dart';

// enum GameSoundTypes {
//   addPeace,
//   explode,
//   missTurn,
//   movePeace,
//   removePeace,
//   startGame,
//   startTurn,
//   tap,
//   tapButton,
//   tapWrong,
//   time,
//   draw,
//   win,
//   lose,
//   correct,
//   dice,
//   hit,
//   bell,
//   queueFinded,
//   chat,
// }

// class SoundPlayerComponent extends BaseController {
//   late AudioPlayer _actionPlayer = AudioPlayer(playerId: "1");
//   late AudioPlayer _musicPlayer = AudioPlayer(playerId: "2");

//   bool letPlaySound = true;
//   RxBool letPlayMusic = RxBool(true);

//   bool isMusicPlaying = false;
//   bool isMusicPaused = false;

//   void playGameSound(GameSoundTypes soundType) {
//     if (!letPlaySound) {
//       return;
//     }
//     String sound = "";
//     switch (soundType) {
//       case GameSoundTypes.addPeace:
//         sound = AppSounds.addPeace;
//         break;
//       case GameSoundTypes.explode:
//         sound = AppSounds.explode;
//         break;
//       case GameSoundTypes.missTurn:
//         sound = AppSounds.missTurn;
//         break;
//       case GameSoundTypes.movePeace:
//         sound = AppSounds.movePeace;
//         break;
//       case GameSoundTypes.removePeace:
//         sound = AppSounds.removePeace;
//         break;
//       case GameSoundTypes.startGame:
//         sound = AppSounds.startGame;
//         break;
//       case GameSoundTypes.startTurn:
//         sound = AppSounds.startTurn;
//         break;
//       case GameSoundTypes.tap:
//         sound = AppSounds.tap;
//         break;
//       case GameSoundTypes.tapButton:
//         sound = AppSounds.tapButton;
//         break;
//       case GameSoundTypes.tapWrong:
//         sound = AppSounds.tapWrong;
//         break;
//       case GameSoundTypes.time:
//         sound = AppSounds.time;
//         break;
//       case GameSoundTypes.draw:
//         sound = AppSounds.draw;
//         break;
//       case GameSoundTypes.win:
//         sound = AppSounds.win;
//         break;
//       case GameSoundTypes.lose:
//         sound = AppSounds.lose;
//         break;
//       case GameSoundTypes.correct:
//         sound = AppSounds.correct;
//         break;
//       case GameSoundTypes.dice:
//         sound = AppSounds.dice;
//         break;
//       case GameSoundTypes.hit:
//         sound = AppSounds.hit;
//         break;
//       case GameSoundTypes.bell:
//         sound = AppSounds.bell;
//         break;
//       case GameSoundTypes.queueFinded:
//         sound = AppSounds.queueFinded;
//         break;
//       case GameSoundTypes.chat:
//         sound = AppSounds.chat;
//         break;
//     }
//     _actionPlayer.play(AssetSource(sound), volume: .25);
//   }

//   changeLetPlayerSound(bool value, {bool isGame = true}) {
//     letPlayMusic.value = value;
//     if (!value) {
//       try {
//         isMusicPlaying = false;
//         isMusicPaused = false;
//         _musicPlayer.stop();
//       } catch (_) {}
//     } else {
//       startPlayMusic(isGame: isGame);
//     }
//   }

//   playRandomMusic(bool isGame) {
//     List<String> songPaths = isGame ? AppMusics.games : AppMusics.themes;
//     final Random random = Random();
//     final index = random.nextInt(songPaths.length);
//     final path = songPaths[index];
//     _musicPlayer.play(AssetSource(path), volume: .2);
//     isMusicPlaying = true;
//     isMusicPaused = false;
//   }

//   Future startPlayMusic({bool isGame = false}) async {
//     if (!letPlayMusic.value) {
//       return;
//     }
//     playRandomMusic(isGame);
//     _musicPlayer.onPlayerStateChanged.listen((state) {
//       if (state == PlayerState.completed) {
//         playRandomMusic(isGame);
//       }
//     });
//   }

//   stopMusic() {
//     if (!letPlayMusic.value) {
//       return;
//     }
//     if (isMusicPlaying) {
//       isMusicPlaying = false;
//       _musicPlayer.stop();
//     }
//   }

//   pauseMusic() {
//     if (!letPlayMusic.value) {
//       return;
//     }
//     if (isMusicPlaying) {
//       isMusicPaused = true;
//       _musicPlayer.pause();
//     }
//   }

//   resumeMusic() {
//     if (!letPlayMusic.value) {
//       return;
//     }
//     if (isMusicPaused) {
//       isMusicPaused = false;
//       _musicPlayer.resume();
//     }
//   }

//   @override
//   void onInit() {
//     _actionPlayer = AudioPlayer(playerId: "1");
//     _musicPlayer = AudioPlayer(playerId: "2");
//     _actionPlayer.setPlayerMode(PlayerMode.lowLatency);
//     _musicPlayer.setPlayerMode(PlayerMode.mediaPlayer);
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     _actionPlayer.dispose();
//     _musicPlayer.dispose();
//     super.onClose();
//   }
// }