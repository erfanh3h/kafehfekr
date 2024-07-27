import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reactions_box.dart';
import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Mill/Models/mill_peace_model.dart';
import 'package:refreshed/refreshed.dart';

import '../../../Core/Base/base_controller.dart';

class MillController extends BaseController {
  RxList<Rx<PlayerModel>> players = RxList();
  RxList<Rx<MillPeaceModel>> peaces = RxList();

  int myId = 1;
  int myGameId = 2;
  String gameId = "gameId";

  RxBool canSelectPeace = RxBool(false);

  RxBool showReactions = RxBool(true);

  RxBool letSendReaction = RxBool(true);

  RxInt player1Peaces = RxInt(3);
  RxInt player2Peaces = RxInt(3);

  RxInt player1PlayedPeaces = RxInt(0);
  RxInt player2PlayedPeaces = RxInt(0);

  RxInt player1RemovedPeaces = RxInt(0);
  RxInt player2RemovedPeaces = RxInt(0);

  RxInt equippedPeaceIndex = RxInt(-1);

  RxInt currentRemover = RxInt(0);
  RxInt currentTurn = RxInt(1);

  RxBool letRemovePeace = RxBool(false);

  Map<int, List<int>> neighborsData = {
    0: [1, 9],
    1: [0, 2, 4],
    2: [1, 14],
    3: [4, 10],
    4: [1, 3, 5, 7],
    5: [4, 13],
    6: [7, 11],
    7: [4, 6, 8],
    8: [7, 12],
    9: [0, 10, 21],
    10: [3, 9, 11, 18],
    11: [6, 10, 15],
    12: [8, 13, 17],
    13: [5, 12, 14, 20],
    14: [2, 13, 23],
    15: [11, 16],
    16: [15, 17, 19],
    17: [12, 16],
    18: [10, 19],
    19: [16, 18, 20, 22],
    20: [13, 19],
    21: [9, 22],
    22: [19, 21, 23],
    23: [14, 22]
  };

  void reactionHandler(dynamic data) {
    final Map reactionData = data;
    final playerId = reactionData['playerId'];
    final reactionId = reactionData['reactionId'];
    changePlayerReaction(playerId, reactionId);
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
        changetimerValue(GameWaitTimes.millSelectTime);
        resetAllPeacesStates();
        break;
      case GameCommands.peaceSelected:
        Map peaceData = data['data'];
        int peaceId = peaceData['target_peace'];
        int gamerId = peaceData['user'];
        if (gamerId == 1) {
          player1PlayedPeaces.value += 1;
        } else {
          player2PlayedPeaces.value += 1;
        }
        for (final peace in peaces) {
          if (peace.value.id == peaceId) {
            peace.value =
                peace.value.changeSelectedUser(newSelectedUser: gamerId);
            removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
            break;
          }
        }
        break;
      case GameCommands.peaceSwaped:
        Map peaceData = data['data'];
        int sourcePeaceId = peaceData['source_peace'];
        int targetPeaceId = peaceData['target_peace'];
        int gamerId = peaceData['user'];
        for (final peace in peaces) {
          if (peace.value.id == sourcePeaceId) {
            peace.value = peace.value.changeSelectedUser(newSelectedUser: null);
            removePeaceStatus(sourcePeaceId, PeaceStatusTypes.isLoading);
          } else if (peace.value.id == targetPeaceId) {
            peace.value =
                peace.value.changeSelectedUser(newSelectedUser: gamerId);
            removePeaceStatus(targetPeaceId, PeaceStatusTypes.isLoading);
          }
        }
        break;
      case GameCommands.peaceRemoved:
        Map peaceData = data['data'];
        int peaceId = peaceData['target_peace'];
        int gamerId = peaceData['user'];
        if (gamerId == 1) {
          player2RemovedPeaces.value += 1;
        } else {
          player1RemovedPeaces.value += 1;
        }
        for (final peace in peaces) {
          if (peace.value.id == peaceId) {
            peace.value = peace.value.changeSelectedUser(newSelectedUser: null);
            removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
            break;
          }
        }
        currentRemover.value = 0;
        break;
      case GameCommands.selectRemovePeace:
        int removerId = data['data'];
        currentRemover.value = removerId;
        if (removerId == myGameId) {
          letRemovePeace.value = true;
          canSelectPeace.value = true;
          for (var neighborId in getEnemyPeacesIndexes()) {
            addPeaceStatus(neighborId, PeaceStatusTypes.canSelected);
          }
        }
        // Get.find<TimerCompanent>().stopTimer();
        // showFinishGameDialog(newData);
        break;
      case GameCommands.finishGame:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        showFinishGameDialog(newData);
        break;
      case GameCommands.surrender:
        Map newData = data['data'];
        Get.find<TimerCompanent>().stopTimer();
        showSurrenderDialog(newData);
        break;
      default:
    }
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

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.addStatus(status: status);
    }
  }

  removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.removeStatus(status: status);
    }
  }

  void getReconnectData(Map newData) {
    List gamers = newData['gamers'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    player1PlayedPeaces.value = gameData['played_peaces'][0];
    player2PlayedPeaces.value = gameData['played_peaces'][1];
    player1RemovedPeaces.value = gameData['removed_peaces'][0];
    player2RemovedPeaces.value = gameData['removed_peaces'][1];
    currentTurn.value = gameData['current_turn'];
    currentRemover.value = gameData['current_remover'];
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

  void onEachButtonTap(MillPeaceModel peace) {
    if (!canSelectPeace.value) {
      print("not your turn");
      return;
    }

    if (letRemovePeace.value) {
      //remove
      if (checkPeaceIsEmpty(peace.id) || peace.selectedUser == myGameId) {
        print("wrong selection");
        return;
      }
      canSelectPeace.value = false;
      letRemovePeace.value = false;
      sendCommand({"id": GameCommands.selectRemovePeace, "data": peace.id});
      addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
      removePeaceStatus(peace.id, PeaceStatusTypes.canSelected);
      for (var neighborId in getEnemyPeacesIndexes()) {
        removePeaceStatus(neighborId, PeaceStatusTypes.canSelected);
      }
    } else {
      if (checkAllOfMyPeacesPlaced()) {
        //swap
        if (equippedPeaceIndex.value == -1) {
          if (peace.selectedUser != myGameId) {
            print("selected before !");
            return;
          }
          equippedPeaceIndex.value = peace.id;
          print(equippedPeaceIndex.value);
          addPeaceStatus(peace.id, PeaceStatusTypes.equiped);
          for (var neighborId in neighborsData[peace.id] ?? []) {
            if (checkPeaceIsEmpty(neighborId)) {
              addPeaceStatus(neighborId, PeaceStatusTypes.canSelected);
            }
          }
        } else {
          if (equippedPeaceIndex.value == peace.id) {
            clearEquipedPeace(peace.id);
            return;
          }
          if (!checkPeaceIsEmpty(peace.id)) {
            print("selected before !");
            return;
          }
          if (!checkSelectedPeaceIsNeighborOfSource(peace.id)) {
            print("not neighbor!");
            return;
          }
          canSelectPeace.value = false;
          sendCommand({
            "id": GameCommands.swapPeace,
            "data": {
              "source": equippedPeaceIndex.value,
              "target": peace.id,
            },
          });
          addPeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.isLoading);
          addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
          clearEquipedPeace(equippedPeaceIndex.value);
        }
      } else {
        //normal select
        if (!checkPeaceIsEmpty(peace.id)) {
          print("selected before !");
          return;
        }
        canSelectPeace.value = false;
        sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
        addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
      }
    }

    // canSelectPeace.value = false;
    // sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    // addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  }

  bool checkSelectedPeaceIsNeighborOfSource(int targetId) {
    return (neighborsData[equippedPeaceIndex.value] ?? []).contains(targetId);
  }

  bool checkAllOfMyPeacesPlaced() {
    if (myGameId == 1) {
      if (player1PlayedPeaces.value < player1Peaces.value) {
        return false;
      } else {
        return true;
      }
    } else {
      if (player2PlayedPeaces.value < player2Peaces.value) {
        return false;
      } else {
        return true;
      }
    }
  }

  bool checkPeaceIsEmpty(int index) {
    return peaces.value[index].value.selectedUser == null;
  }

  void clearEquipedPeace(int index) {
    equippedPeaceIndex.value = -1;
    removePeaceStatus(index, PeaceStatusTypes.equiped);
    for (var neighborId in neighborsData[index] ?? []) {
      removePeaceStatus(neighborId, PeaceStatusTypes.canSelected);
    }
  }

  List<int> getEnemyPeacesIndexes() {
    List<int> result = [];
    for (var peaceData in peaces.value) {
      if (peaceData.value.selectedUser != null &&
          peaceData.value.selectedUser != myGameId) {
        result.add(peaceData.value.id);
      }
    }
    return result;
  }

  void resetAllPeacesStates() {
    for (var neighborId in getEnemyPeacesIndexes()) {
      removePeaceStatus(neighborId, PeaceStatusTypes.canSelected);
    }
    letRemovePeace.value = false;
    if (equippedPeaceIndex.value != -1) {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
      for (var neighborId in neighborsData[equippedPeaceIndex.value] ?? []) {
        if (checkPeaceIsEmpty(neighborId)) {
          removePeaceStatus(neighborId, PeaceStatusTypes.canSelected);
        }
      }
      clearEquipedPeace(equippedPeaceIndex.value);
    }
  }

  void surrenderFnction() {
    DialogComponent().showIconicSelectionDialog(
      AppTexts.surrender.tr,
      AppTexts.wanaSurrenderGame.tr,
      GeneralIcons.death,
      AppColors.loseColor,
      () {
        Get.find<GameSocketManager>()
            .sendCommand({"id": GameCommands.surrender});
        Get.closeAllDialogs();
      },
      () {
        Get.closeAllDialogs();
      },
    );
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

  void showFinishRoundDialog(int roundWinner) {
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
  }

  void showFinishGameDialog(Map newData) {
    int gameWinner = newData['Winner'] ?? 0;
    if (gameWinner == 0) {
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        AppTexts.gameDrawed.tr,
        GeneralIcons.draw,
        AppColors.drawColor,
        coin: 0,
        cup: 0,
      );
    } else {
      String dialogMessage = "";
      String dialogIcon = "";
      Color dialogColor = Colors.white;
      int cup = 0;
      int coin = 0;
      if (gameWinner == myGameId) {
        dialogMessage = AppTexts.youWinGame.tr;
        dialogIcon = GeneralIcons.win;
        dialogColor = AppColors.winColor;
        cup = CupsCount.tictactoeWin;
        coin = CoinsCount.tictactoeWin;
      } else {
        dialogMessage = AppTexts.youLoseGame.tr;
        dialogIcon = GeneralIcons.lose;
        dialogColor = AppColors.loseColor;
        cup = CupsCount.tictactoeLose;
        coin = CoinsCount.tictactoeLose;
      }
      DialogComponent().showIconicDialog(
        AppTexts.endGame.tr,
        dialogMessage,
        dialogIcon,
        dialogColor,
        coin: coin,
        cup: cup,
      );
    }
  }

  void showSurrenderDialog(Map newData) {
    int gamerId = newData['gamer_id'] ?? 1;
    String dialogMessage = "";
    String dialogIcon = "";
    Color dialogColor = Colors.white;
    int cup = 0;
    int coin = 0;
    if (gamerId == myGameId) {
      dialogMessage = AppTexts.youSurrenderGame.tr;
      dialogIcon = GeneralIcons.lose;
      dialogColor = AppColors.loseColor;
      cup = CupsCount.tictactoeLose;
      coin = CoinsCount.tictactoeLose;
    } else {
      dialogMessage = AppTexts.enemySurrenderGame.tr;
      dialogIcon = GeneralIcons.win;
      dialogColor = AppColors.winColor;
      cup = CupsCount.tictactoeWin;
      coin = CoinsCount.tictactoeWin;
    }
    DialogComponent().showIconicDialog(
      AppTexts.endGame.tr,
      dialogMessage,
      dialogIcon,
      dialogColor,
      coin: coin,
      cup: cup,
    );
  }

  void changeShowReactionStatus() {
    showReactions.value = !showReactions.value;
  }

  @override
  void onInit() async {
    Get.find<GameSocketManager>().initSocket(
      commandHandler: commandHandler,
      reactionHandler: reactionHandler,
    );
    for (var i = 0; i < 24; i++) {
      peaces.add(Rx(MillPeaceModel(id: i, currentStatuses: [])));
    }
    super.onInit();
  }
}
