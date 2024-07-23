import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/status_types.dart';
import 'package:kafehfekr/Feature/TicTacToe/Models/tictactoe_peace_model.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class TicTacToeController extends BaseController {
  RxString logText = RxString('');

  // List<PlayerModel> players = [
  RxList<Rx<PlayerModel>> players = RxList();
  RxList<Rx<TicTacToePeaceModel>> peaces = RxList();

  int myId = 1;
  int myGameId = 2;
  String gameId = "gameId";

  RxBool canSelectPeace = RxBool(false);

  RxInt currentRound = RxInt(1);
  int maxRound = 2;

  RxInt player1Score = RxInt(0);
  RxInt player2Score = RxInt(0);

  RxInt currentTurn = RxInt(1);

  Rx<GameStatusTypes> gameStatus = Rx(GameStatusTypes.none);

  void setPlayerData(int index, PlayerModel playerData) {
    switch (index) {}
  }

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.gameData:
        Map gameData = data['data'];
        List gamers = gameData['gamers'];
        for (var gamerData in gamers) {
          players.add(Rx(PlayerModel.fromJson(gamerData)));
        }
        break;
      case GameCommands.reconnectData:
        Map newData = data['data'];
        getReconnectData(newData);
        break;
      case GameCommands.currentTurn:
        int turn = data['data'];
        currentTurn.value = turn;
        if (turn == myGameId) {
          canSelectPeace.value = true;
        } else {
          canSelectPeace.value = false;
        }
        changetimerValue(GameWaitTimes.tictactoeRoundTime);
        break;
      case GameCommands.peaceSelected:
        Map peaceData = data['data'];
        int peaceId = peaceData['target_peace'];
        for (final peace in peaces) {
          if (peace.value.id == peaceId) {
            peace.value = peace.value
                .changeSelectedUser(newSelectedUser: peaceData["user"]);
            removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
            break;
          }
        }
        break;
      case GameCommands.newRound:
        int newRound = data['data'];
        currentRound.value = newRound;
        resetPeaces();
        break;
      case GameCommands.finishRound:
        Map newData = data['data'];
        int roundWinner = newData['Winner'] ?? 0;
        Get.find<TimerCompanent>().stopTimer();
        if (roundWinner == 0) {
          DialogComponent().showIconicDialog(
            AppTexts.endRound.tr,
            AppTexts.roundDrawed.tr,
            GeneralIcons.drawRound,
            AppColors.drawColor,
          );
        } else {
          String dialogMessage = "";
          String dialogIcon = "";
          Color dialogColor = Colors.white;
          if (roundWinner == 1) {
            player1Score.value += 1;
          } else if (roundWinner == 2) {
            player2Score.value += 1;
          }
          if (roundWinner == myGameId) {
            dialogMessage = AppTexts.youWinThisRound.tr;
            dialogIcon = GeneralIcons.happy;
            dialogColor = AppColors.winColor;
          } else {
            dialogMessage = AppTexts.youLoseThisRound.tr;
            dialogIcon = GeneralIcons.sad;
            dialogColor = AppColors.loseColor;
          }
          DialogComponent().showIconicDialog(
            'پایان دور',
            dialogMessage,
            dialogIcon,
            dialogColor,
          );
        }
        break;
      case GameCommands.finishGame:
        Map newData = data['data'];
        int gameWinner = newData['Winner'] ?? 0;
        Get.find<TimerCompanent>().stopTimer();
        if (gameWinner == 0) {
          DialogComponent().showIconicDialog(
            AppTexts.endGame.tr,
            AppTexts.gameDrawed.tr,
            GeneralIcons.draw,
            AppColors.drawColor,
          );
        } else {
          String dialogMessage = "";
          String dialogIcon = "";
          Color dialogColor = Colors.white;
          if (gameWinner == myGameId) {
            dialogMessage = AppTexts.youWinGame.tr;
            dialogIcon = GeneralIcons.win;
            dialogColor = AppColors.winColor;
          } else {
            dialogMessage = AppTexts.youLoseGame.tr;
            dialogIcon = GeneralIcons.lose;
            dialogColor = AppColors.loseColor;
          }
          DialogComponent().showIconicDialog(
            AppTexts.endGame.tr,
            dialogMessage,
            dialogIcon,
            dialogColor,
          );
        }
        break;
      default:
    }
  }

  bool isThisUserTurn(int gamerId) {
    return currentTurn.value == gamerId;
  }

  void changetimerValue(int value) {
    Get.find<TimerCompanent>().startTimer(value);
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int? peaceId, PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.id == peaceId) {
        peaces.value[i].value = peaces.value[i].value.addStatus(status: status);
        break;
      }
    }
  }

  removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.id == peaceId) {
        peaces.value[i].value =
            peaces.value[i].value.removeStatus(status: status);
        break;
      }
    }
  }

  void getReconnectData(Map newData) {
    List gamers = newData['gamers'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentRound.value = gameData['current_round'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_turn'];
    for (var gamerData in gamers) {
      players.add(Rx(PlayerModel.fromJson(gamerData)));
    }
    for (var i = 0; i < boardData.length; i++) {
      if (boardData[i] == 0) {
        continue;
      }
      peaces[i].value =
          peaces[i].value.changeSelectedUser(newSelectedUser: boardData[i]);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time =
          GameWaitTimes.tictactoeRoundTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    }
  }

  void sendCommand(Map data) {
    Get.find<GameSocketManager>().sendCommand(data);
  }

  void onEachButtonTap(TicTacToePeaceModel peace) {
    if (!canSelectPeace.value) {
      print("not your turn");
      return;
    }
    if (peace.selectedUser != null) {
      print("selected before !");
      return;
    }
    canSelectPeace.value = false;
    sendCommand({"id": 'SelectPeace', "data": peace.id});
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  }

  @override
  void onInit() async {
    Get.find<GameSocketManager>().initSocket(commandHandler: commandHandler);
    for (var i = 0; i < 9; i++) {
      peaces.add(Rx(TicTacToePeaceModel(id: i, currentStatuses: [])));
    }
    super.onInit();
  }
}
