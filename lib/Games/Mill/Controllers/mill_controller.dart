import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Mill/Models/mill_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class MillController extends BaseGameController {
  RxList<Rx<MillPeaceModel>> peaces = RxList();

  RxInt player1Peaces = RxInt(9);
  RxInt player2Peaces = RxInt(9);

  RxInt player1PlayedPeaces = RxInt(0);
  RxInt player2PlayedPeaces = RxInt(0);

  RxInt player1RemovedPeaces = RxInt(0);
  RxInt player2RemovedPeaces = RxInt(0);

  RxInt equippedPeaceIndex = RxInt(-1);

  RxInt currentRemover = RxInt(0);

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

  @override
  void currentTurnFunction(Map data) {
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.millSelectTime);
    resetAllPeacesStates();
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['target_peace'];
    int gamerId = peaceData['user'];
    if (gamerId == 1) {
      player1PlayedPeaces.value += 1;
    } else {
      player2PlayedPeaces.value += 1;
    }
    removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    removeAllPeacesStatus(PeaceStatusTypes.isLoading);
    peaces[peaceId].value =
        peaces[peaceId].value.changeSelectedUser(newSelectedUser: gamerId);
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    int currentRemoverGameId = gameData['current_remover'];
    player1PlayedPeaces.value = gameData['played_peaces'][0];
    player2PlayedPeaces.value = gameData['played_peaces'][1];
    player1RemovedPeaces.value = gameData['removed_peaces'][0];
    player2RemovedPeaces.value = gameData['removed_peaces'][1];
    currentTurn.value = gameData['current_turn'];
    currentRemover.value = gameData['current_remover'];
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
    if (currentRemoverGameId == myGameId) {
      letRemovePeace.value = true;
      canSelectPeace.value = true;
      for (var neighborId in getEnemyPeacesIndexes()) {
        addPeaceStatus(neighborId, PeaceStatusTypes.canHitted);
      }
    }
    // if (timerData['is_user_turn']) {
    final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
    // }
  }

  @override
  void peaceSwapedFunction(Map data) {
    Map peaceData = data['data'];
    int sourcePeaceId = peaceData['source_peace'];
    int targetPeaceId = peaceData['target_peace'];
    int gamerId = peaceData['user'];
    for (final peace in peaces) {
      if (peace.value.id == sourcePeaceId) {
        peace.value = peace.value.changeSelectedUser(newSelectedUser: null);
        removePeaceStatus(sourcePeaceId, PeaceStatusTypes.isLoading);
      } else if (peace.value.id == targetPeaceId) {
        removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
        peace.value = peace.value.changeSelectedUser(newSelectedUser: gamerId);
        peace.value =
            peace.value.addStatus(status: PeaceStatusTypes.lastTurnPlayed);
        removePeaceStatus(targetPeaceId, PeaceStatusTypes.isLoading);
      }
    }
  }

  @override
  void peaceRemovedFunction(Map data) {
    showInteraction(sound: GameSoundTypes.hit);
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
  }

  @override
  void selectRemovePeaceFunction(Map data) {
    int removerId = data['data'];
    currentRemover.value = removerId;
    changetimerValue(GameWaitTimes.millRemoveTime);
    if (removerId == myGameId) {
      letRemovePeace.value = true;
      canSelectPeace.value = true;
      for (var neighborId in getEnemyPeacesIndexes()) {
        addPeaceStatus(neighborId, PeaceStatusTypes.canHitted);
      }
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    MillPeaceModel peace = tappedPeace as MillPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }

    if (letRemovePeace.value) {
      //remove
      if (!peace.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
        showInteraction(text: AppTexts.cantRemoveThisPiece.tr);
        return;
      }
      // if (checkPeaceIsEmpty(peace.id) || peace.selectedUser == myGameId) {
      //   showInteraction(text: AppTexts.cantRemoveYourPiece.tr);
      //   return;
      // }
      letRemovePeace.value = false;
      canSelectPeace.value = false;
      sendCommand({"id": GameCommands.selectRemovePeace, "data": peace.id});
      addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
      removePeaceStatus(peace.id, PeaceStatusTypes.canHitted);
      for (var neighborId in getEnemyPeacesIndexes()) {
        removePeaceStatus(neighborId, PeaceStatusTypes.canHitted);
      }
      showInteraction(sound: GameSoundTypes.removePeace);
    } else {
      if (checkAllOfMyPeacesPlaced()) {
        //swap
        if (equippedPeaceIndex.value != -1) {
          if (equippedPeaceIndex.value == peace.id) {
            releasePeace();
          } else if (peace.selectedUser == myGameId) {
            releasePeace();
            equipPeace(peace.id);
          } else {
            if (peace.selectedUser != myGameId && peace.selectedUser != null) {
              showInteraction(text: AppTexts.cantSwapEnemyPiece.tr);
              return;
            }
            if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
              showInteraction(text: AppTexts.cantSelect.tr);
              return;
            }
            if (equippedPeaceIndex.value == peace.id) {
              showInteraction(sound: GameSoundTypes.removePeace);
              return;
            }
            if (!checkPeaceIsEmpty(peace.id)) {
              showInteraction(text: AppTexts.selectedBefore.tr);
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
            addPeaceStatus(
                equippedPeaceIndex.value, PeaceStatusTypes.isLoading);
            addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
            releasePeace();
            showInteraction(sound: GameSoundTypes.movePeace);
          }
        } else {
          equipPeace(peace.id);
        }
      } else {
        //normal select
        if (!checkPeaceIsEmpty(peace.id)) {
          showInteraction(text: AppTexts.selectedBefore.tr);
          return;
        }
        canSelectPeace.value = false;
        showInteraction(sound: GameSoundTypes.tap);
        sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
        addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
      }
    }
  }

  void equipPeace(int index) {
    if (peaces[index].value.selectedUser != myGameId) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    equippedPeaceIndex.value = index;
    addPeaceStatus(index, PeaceStatusTypes.equiped);
    int currentPeaceLeft = 0;
    if (myGameId == 1) {
      currentPeaceLeft = player1Peaces.value - player1RemovedPeaces.value;
    } else {
      currentPeaceLeft = player2Peaces.value - player2RemovedPeaces.value;
    }
    if (currentPeaceLeft <= 3) {
      for (var peace in peaces.value) {
        final index = peace.value.id;
        if (checkPeaceIsEmpty(index)) {
          addPeaceStatus(index, PeaceStatusTypes.canSelected);
        }
      }
    } else {
      for (var neighborId in neighborsData[index] ?? []) {
        if (checkPeaceIsEmpty(neighborId)) {
          addPeaceStatus(neighborId, PeaceStatusTypes.canSelected);
        }
      }
    }
  }

  void releasePeace() {
    removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    try {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    } catch (_) {}
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    equippedPeaceIndex.value = -1;
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
      removePeaceStatus(neighborId, PeaceStatusTypes.canHitted);
      removePeaceStatus(neighborId, PeaceStatusTypes.isLoading);
    }
    letRemovePeace.value = false;
    if (equippedPeaceIndex.value != -1) {
      releasePeace();
    }
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

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  initPieces() {
    for (var i = 0; i < 24; i++) {
      peaces.add(Rx(MillPeaceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Mill;
    initPieces();
  }
}
