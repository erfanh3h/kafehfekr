import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reactions_box.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class BaseGameController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();

  late String myId;
  int myGameId = 0;
  late String gameId;
  RxBool canSelectPeace = RxBool(false);
  RxBool showReactions = RxBool(true);
  RxBool letSendReaction = RxBool(true);

  RxInt currentRound = RxInt(1);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  RxInt currentTurn = RxInt(1);

  RxBool letPlaySound = RxBool(false);

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
        startGameFunction(data);
        break;
      case GameCommands.currentTurn:
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
      case GameCommands.surrender:
        surrenderFunction(data);
        break;
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

  void playerScoreFunction(Map data) {}

  void onEachButtonTap(dynamic tappedPeace) {}

  void gameDataFunction(Map data) {
    Map gameData = data['data'];
    List gamers = gameData['gamers'];
    for (var gamerData in gamers) {
      PlayerModel newPlayer = PlayerModel.fromJson(gamerData);
      players.add(Rx(newPlayer));
      if (newPlayer.userId == myId) {
        myGameId = newPlayer.gamerId;
      }
    }
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
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    changePlayerReaction(playerId, reactionId);
  }

  void finishGameFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    FunctionsLibraryClass.showFinishGameDialog(
      newData['Winner'],
      myGameId,
      gameType,
    );
  }

  void surrenderFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    FunctionsLibraryClass.showSurrenderDialog(
      newData['gamer_id'],
      myGameId,
      gameType,
    );
  }

  void finishReconnectTimerFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    FunctionsLibraryClass.showFinishReconnectTimeDialog(
      newData['user_id'],
      myId,
      gameType,
    );
  }

  void onUserDisconnectedFunction(Map data) {
    Map newData = data['data'];
    String userId = newData['user_id'];
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
  }

  bool isThisUserTurn(int gamerId) {
    return currentTurn.value == gamerId;
  }

  Color returnTimerColor() {
    if (currentTurn.value == 1) {
      return AppColors.imageRedColor;
    } else if (currentTurn.value == 2) {
      return AppColors.imageBlueColor;
    }
    return AppColors.darkColor;
  }

  void changetimerValue(int value) {
    Get.find<TimerCompanent>().startTimer(value);
  }

  changePlayerReaction(int? gamerId, int? reactionId, {int? removeTimer}) {
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.gamerId == gamerId) {
        if (showReactions.value) {
          players.value[i].value = players.value[i].value
              .changeReactionId(newReactionId: reactionId);
        }
        Future.delayed(Duration(seconds: removeTimer ?? 5)).then((_) {
          players.value[i].value = players.value[i].value.changeReactionId();
          letSendReaction.value = true;
        });
        break;
      }
    }
  }

  void sendCommand(Map data) {
    Get.find<GameSocketManager>().sendCommand(data);
  }

  void showReactionBox() {
    if (letSendReaction.value) {
      Get.bottomSheet(
        GlobalReactionsBox(
          onTap: () {
            letSendReaction.value = false;
          },
        ),
        backgroundColor: AppColors.lightColor,
      );
    }
  }

  void changeShowReactionStatus() {
    showReactions.value = !showReactions.value;
  }

  void changeLetPlaySound() {
    letPlaySound.value = !letPlaySound.value;
    Get.find<SoundPlayerComponent>().changeLetPlayerSound(letPlaySound.value);
  }

  void showInfo() {
    print(gameType.name);
  }

  @override
  void onInit() {
    myId = Get.find<GlobalController>().idController.text;
    gameId = Get.find<GlobalController>().gameIdController.text;
    Get.put(GameSocketManager());
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
      gameId: gameId,
      myId: myId,
    );
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }
}
