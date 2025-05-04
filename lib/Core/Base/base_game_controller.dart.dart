import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_koris_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_stickers_box.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/game_play_controller.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class BaseGameController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();

  late String myId;
  int myGameId = 0;
  late String gameId;
  RxBool canSelectPeace = RxBool(false);
  RxBool showStickers = RxBool(true);
  RxBool showKoris = RxBool(true);
  RxBool letSendSticker = RxBool(true);
  RxBool letSendKori = RxBool(true);

  RxInt currentRound = RxInt(1);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  RxInt currentTurn = RxInt(0);

  RxBool letPlayMusic = RxBool(true);
  RxBool isGameStarted = RxBool(false);
  RxBool isGameFinished = RxBool(false);

  late GameTypes gameType;

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gameData:
        gameDataFunction(data);
        break;
      case GameCommands.reconnectData:
        reconnectDataFuntcion(data);
        break;
      case GameCommands.startGame:
        isPageLoading.value = false;
        startGameFunction(data);
        break;
      case GameCommands.currentTurn:
        isPageLoading.value = false;
        currentTurnFunction(data);
        break;
      case GameCommands.selectPeaceResult:
        selectPeaceResult(data);
        break;
      case GameCommands.peaceSelected:
        peaceSelectedFunction(data);
        break;
      case GameCommands.peaceSwaped:
        peaceSwapedFunction(data);
        break;
      case GameCommands.peaceRemoved:
        peaceRemovedFunction(data);
        break;
      case GameCommands.selectRemovePeace:
        selectRemovePeaceFunction(data);
        break;
      case GameCommands.newRound:
        newRoundFunction(data);
        break;
      case GameCommands.newTurnRound:
        newTurnRoundFunction(data);
        break;
      case GameCommands.finishRound:
        finishRoundFunction(data);
        break;
      case GameCommands.finishTurnRound:
        finishTurnRoundFunction(data);
        break;
      case GameCommands.finishGame:
        finishGameFunction(data);
        break;
      // case GameCommands.surrender:
      //   surrenderFunction(data);
      //   break;
      case GameCommands.userDisconnected:
        onUserDisconnectedFunction(data);
        break;
      case GameCommands.userReconnected:
        onUserReconnectedFunction(data);
        break;
      case GameCommands.finishReconnectTime:
        finishReconnectTimerFunction(data);
        break;
      case GameCommands.playerScore:
        playerScoreFunction(data);
        break;
      case GameCommands.waitTime:
        waitTimeFunction(data);
        break;
      case GameCommands.notPlayedTurns:
        notPlayedTurnsFunction(data);
        break;
      case GameCommands.gameFinished:
        Get.find<GamePlayController>().deviceFinishGameFunction();
        break;
      case GameCommands.gamePlayData:
        Get.find<GamePlayController>().gamePlayDataFunction(data);
        break;
      case GameCommands.gamePlayNavigate:
        Get.find<GamePlayController>().navigateToGameFunction(data);
        break;
      case GameCommands.gamePlayTime:
        Get.find<GamePlayController>().changeTimeFunction(data);
        break;
      default:
    }
  }

  void currentTurnFunction(Map data) {}

  void startGameFunction(Map data) {}

  void peaceSelectedFunction(Map data) {}

  void peaceSwapedFunction(Map data) {}

  void peaceRemovedFunction(Map data) {}

  void selectRemovePeaceFunction(Map data) {}

  void newRoundFunction(Map data) {}

  void newTurnRoundFunction(Map data) {}

  void selectPeaceResult(Map data) {}

  void finishRoundFunction(Map data) {}

  void finishTurnRoundFunction(Map data) {}

  void waitTimeFunction(Map data) {
    int time = data['data'];
    stopTimer();
    changetimerValue(time);
  }

  void playerScoreFunction(Map data) {}

  void onEachButtonTap(dynamic tappedPeace) {}

  void gameDataFunction(Map data) async {
    isPageLoading.value = false;
    changetimerValue(GameWaitTimes.startGameTime);
    Map gameData = data['data'];
    List gamers = gameData['gamers'];
    for (var gamerData in gamers) {
      PlayerModel newPlayer = PlayerModel.fromJson(gamerData);
      players.add(Rx(newPlayer));
      if (newPlayer.userId == myId) {
        myGameId = newPlayer.gamerId;
      }
    }
    for (var i = 0; i < 5; i++) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.time);
      await Future.delayed(const Duration(seconds: 1));
    }
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.bell);
    isGameStarted.value = true;
  }

  void reconnectDataFuntcion(Map data) {
    Map newData = data['data'];
    List gamers = newData['gamers'];
    for (var gamerData in gamers) {
      PlayerModel newPlayer = PlayerModel.fromJson(gamerData);
      players.add(Rx(newPlayer));
      if (newPlayer.userId == myId) {
        myGameId = newPlayer.gamerId;
      }
    }
    isPageLoading.value = false;
    isGameStarted.value = true;
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    changePlayerReaction(playerId, reactionId);
  }

  void notPlayedTurnsFunction(dynamic data) {
    Map newData = data['data'];
    int gamerId = newData['gamer_id'];
    int count = newData['count'];
    if (gamerId == 1) {
      players[0].value = players[0].value.copyWith(notPlayedTurns: count);
    } else {
      players[1].value = players[1].value.copyWith(notPlayedTurns: count);
    }
  }

  void finishGameFunction(Map data) {
    isGameFinished.value = true;
    canSelectPeace.value = false;
    Map newData = data['data'];
    stopTimer();
    FunctionsLibraryClass.showFinishGameDialog(
      newData['Winner'],
      myGameId,
      gameType,
    );
  }

  void finishReconnectTimerFunction(Map data) {
    Map newData = data['data'];
    stopTimer();
    FunctionsLibraryClass.showFinishReconnectTimeDialog(
      newData['user_id'],
      myId,
      gameType,
    );
  }

  void onUserDisconnectedFunction(Map data) {
    stopTimer();
    Map newData = data['data'];
    String userId = newData['user_id'];
    int time = newData['time'];
    DialogComponent()
        .showTimerDialog(time: time, text: AppTexts.waitOpponent.tr);
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.userId == userId) {
        players[i].value = players[i].value.copyWith(isDisconnected: true);
        break;
        // int maxTime = players[i].value.disconnectTime;
        // while (maxTime >= 0) {
        //   if (players[i].value.isDisconnected) {
        //     Future.delayed(Duration(seconds: 1));
        //   }
        // }
      }
    }
  }

  void onUserReconnectedFunction(Map data) {
    Map newData = data['data'];
    String userId = newData['user_id'];
    int time = newData['time'];
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.userId == userId) {
        players[i].value = players[i].value.copyWith(isDisconnected: false);
        break;
        // int maxTime = players[i].value.disconnectTime;
        // while (maxTime >= 0) {
        //   if (players[i].value.isDisconnected) {
        //     Future.delayed(Duration(seconds: 1));
        //   }
        // }
      }
    }
    changetimerValue(time);
    Get.closeDialog();
  }

  bool isThisUserTurn(int gamerId) {
    return currentTurn.value == gamerId;
  }

  Color? returnTimerColor() {
    if (currentTurn.value == 1) {
      return AppColors.imageRedColor;
    } else if (currentTurn.value == 2) {
      return AppColors.imageBlueColor;
    }
    return null;
  }

  void changetimerValue(int value) {
    Get.find<TimerCompanent>().startTimer(value);
  }

  changePlayerReaction(int gamerId, int reactionId, {int? removeTimer}) {
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.gamerId == gamerId) {
        if ((reactionId <= 100 && showStickers.value) ||
            (reactionId > 100 && showKoris.value)) {
          players.value[i].value = players.value[i].value
              .changeReactionId(newReactionId: reactionId);
          showInteraction(sound: GameSoundTypes.chat);
        }
        Future.delayed(Duration(seconds: removeTimer ?? 5)).then((_) {
          players.value[i].value = players.value[i].value.changeReactionId();
          if (reactionId <= 100) {
            letSendSticker.value = true;
          } else {
            letSendKori.value = true;
          }
        });
        break;
      }
    }
  }

  void sendCommand(Map data) {
    Get.find<GameSocketManager>().sendCommand(data);
  }

  void showStickerBox() {
    if (letSendSticker.value) {
      Get.bottomSheet(
        GlobalStickersBox(
          onTap: () {
            letSendSticker.value = false;
          },
        ),
        backgroundColor: AppColors.darkColor,
      );
    }
  }

  void changeShowStickerStatus() {
    showStickers.value = !showStickers.value;
  }

  void showKoriBox() {
    if (letSendKori.value) {
      Get.bottomSheet(
        GlobalKorisBox(
          onTap: () {
            letSendKori.value = false;
          },
        ),
        backgroundColor: AppColors.darkColor,
      );
    }
  }

  void changeShowKoriStatus() {
    showKoris.value = !showKoris.value;
  }

  void changeLetPlayMusic() {
    letPlayMusic.value = !letPlayMusic.value;
    Get.find<SoundPlayerComponent>().changeLetPlayerSound(letPlayMusic.value);
  }

  void showInfo() {
    Get.bottomSheet(
      GlobalGameGuideWidget(gameType: gameType),
      backgroundColor: AppColors.darkColor,
    );
  }

  void showInteraction({String? text, GameSoundTypes? sound}) {
    Get.find<SoundPlayerComponent>()
        .playGameSound(sound ?? GameSoundTypes.tapWrong);
    if (text != null) {
      DialogComponent().showToast(label: text);
    }
  }

  String getActiveGamerUsername() {
    if (currentTurn.value == 1) {
      return players[0].value.name;
    }
    if (currentTurn.value == 2) {
      return players[1].value.name;
    }
    return "";
  }

  String getInActiveGamerUsername() {
    if (currentTurn.value == 1) {
      return players[1].value.name;
    }
    if (currentTurn.value == 2) {
      return players[0].value.name;
    }
    return "";
  }

  stopTimer() {
    Get.find<TimerCompanent>().stopTimer();
  }

  @override
  void onInit() {
    letPlayMusic.value = Get.find<SoundPlayerComponent>().letPlayMusic.value;
    isPageLoading.value = true;
    myId = Get.find<GlobalController>().userId!;
    Get.find<GameSocketManager>()
        .changeCommandHandler(commandHandler: commandHandler);
    Get.find<GameSocketManager>()
        .changeReactionHandler(reactionHandler: reactionHandler);
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }
}
