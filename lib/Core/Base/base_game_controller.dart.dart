import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
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

  int myId = 1;
  int myGameId = 2;
  String gameId = "gameId";
  RxBool canSelectPeace = RxBool(false);
  RxBool showReactions = RxBool(true);
  RxBool letSendReaction = RxBool(true);

  RxInt currentRound = RxInt(1);
  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);
  RxInt currentTurn = RxInt(1);

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gameData:
        gameDataFunction(data);
        break;
      case GameCommands.reconnectData:
        reconnectDataFuntcion(data);
        break;
      case GameCommands.currentTurn:
        currentTurnFunction(data);
        break;
      case GameCommands.peaceSelected:
        peaceSelectedFunction(data);
        break;
      case GameCommands.newRound:
        newRoundFunction(data);
        break;
      case GameCommands.finishRound:
        finishRoundFunction(data);
        break;
      case GameCommands.finishGame:
        finishGameFunction(data);
        break;
      case GameCommands.surrender:
        surrenderFunction(data);
        break;
      default:
    }
  }

  void gameDataFunction(Map data) {
    Map gameData = data['data'];
    List gamers = gameData['gamers'];
    for (var gamerData in gamers) {
      players.add(Rx(PlayerModel.fromJson(gamerData)));
    }
  }

  void reconnectDataFuntcion(Map data) {
    Map newData = data['data'];
    List gamers = newData['gamers'];
    for (var gamerData in gamers) {
      players.add(Rx(PlayerModel.fromJson(gamerData)));
    }
  }

  void reactionHandler(dynamic data) {
    final playerId = data['playerId'];
    final reactionId = data['reactionId'];
    changePlayerReaction(playerId, reactionId);
  }

  void currentTurnFunction(Map data) {}

  void peaceSelectedFunction(Map data) {}

  void newRoundFunction(Map data) {}

  void finishRoundFunction(Map data) {}

  void finishGameFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    FunctionsLibraryClass.showFinishGameDialog(
      newData['Winner'],
      myGameId,
      GameTypes.tictactoe,
    );
  }

  void surrenderFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    FunctionsLibraryClass.showSurrenderDialog(
      newData['gamer_id'],
      myGameId,
      GameTypes.tictactoe,
    );
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

  changePlayerReaction(int? playerId, int? reactionId, {int? removeTimer}) {
    for (var i = 0; i < players.length; i++) {
      if (players[i].value.id == playerId) {
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

  void onEachButtonTap(dynamic tappedPeace) {}

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
}
