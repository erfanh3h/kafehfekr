import 'package:flutter/foundation.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Checkers/Models/checkers_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class CheckersController extends BaseGameController {
  RxList<Rx<CheckersPeaceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(12);
  RxInt player2Pawns = RxInt(12);

  RxInt equippedPeaceIndex = RxInt(-1);

  List checkMoveList = [];
  List currentPossibleMoves = [];

  List<int> indexToCoordinate(int index) {
    final x = index % 8;
    final y = index ~/ 8;
    return [x, y];
  }

  int coordinateToIndex(int x, int y) {
    final index = y * 8 + x;
    return index;
  }

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
    changetimerValue(GameWaitTimes.checkersTurnTime);
    releasePeace();
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final sourceRIndex = selectionData['s_r_index'];
    final sourceCIndex = selectionData['s_c_index'];
    final targetRIndex = selectionData['t_r_index'];
    final targetCIndex = selectionData['t_c_index'];
    final int gamerId = selectionData['gamer_id'];
    final index = coordinateToIndex(sourceRIndex, sourceCIndex);
    addPossibleMoves(index, gamerId);
    final moveResult = movePawn(
        sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, gamerId);
    if (moveResult) {
      releasePeace();
    }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    player1Pawns.value = gameData['pawns_count'][0];
    player2Pawns.value = gameData['pawns_count'][1];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    final int time = GameWaitTimes.checkersTurnTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    CheckersPeaceModel peace = tappedPeace as CheckersPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (equippedPeaceIndex.value != -1) {
      if (equippedPeaceIndex.value == peace.id) {
        releasePeace();
      } else if (peace.selectedUser == myGameId) {
        releasePeace();
        equipPeace(peace.id);
      } else {
        if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
          showInteraction(text: AppTexts.cantSelect.tr);
          return;
        }
        final List sourceData = indexToCoordinate(equippedPeaceIndex.value);
        final sourceRIndex = sourceData[0];
        final sourceCIndex = sourceData[1];
        final List targetData = indexToCoordinate(peace.id);
        final targetRIndex = targetData[0];
        final targetCIndex = targetData[1];
        sendCommand({
          "id": GameCommands.selectPeace,
          "data": {
            's_c_index': sourceCIndex,
            's_r_index': sourceRIndex,
            't_c_index': targetCIndex,
            't_r_index': targetRIndex,
          }
        });
        releasePeace();
        // final moveResult = movePawn(
        //     sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, myGameId);
        // if (moveResult) {
        //   releasePeace();
        // }
      }
    } else {
      if (peace.selectedUser != 0 && peace.selectedUser == myGameId) {
        equipPeace(peace.id);
      }
    }
  }

  void equipPeace(int index) {
    equippedPeaceIndex.value = index;
    addPeaceStatus(index, PeaceStatusTypes.equiped);
    addPossibleMoves(index, myGameId);
  }

  void releasePeace() {
    try {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    } catch (_) {}
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    equippedPeaceIndex.value = -1;
    currentPossibleMoves.clear();
  }

  void addPossibleMoves(int index, int gamerId) {
    List coordinates = indexToCoordinate(index);
    List movesPossibleList =
        getPossibleMovesOfPeace(coordinates[0], coordinates[1], gamerId);
    for (var dataRaw in movesPossibleList) {
      List? coordinates = dataRaw[0];
      if (coordinates != null) {
        final peaceId = coordinateToIndex(coordinates[0], coordinates[1]);
        addPeaceStatus(peaceId, PeaceStatusTypes.canSelected);
        currentPossibleMoves.add(dataRaw);
      }
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  changePeaceSelectedUser(int peaceId, int? selectedUser, {bool? isSuperPawn}) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changeSelectedUser(
            newSelectedUser: selectedUser, newIsSuperPawn: isSuperPawn);
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  initPeaces() {
    for (var i = 0; i < 64; i++) {
      peaces.add(
          Rx(CheckersPeaceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
    changePeaceSelectedUser(0, 1);
    changePeaceSelectedUser(2, 1);
    changePeaceSelectedUser(4, 1);
    changePeaceSelectedUser(6, 1);
    changePeaceSelectedUser(9, 1);
    changePeaceSelectedUser(11, 1);
    changePeaceSelectedUser(13, 1);
    changePeaceSelectedUser(15, 1);
    changePeaceSelectedUser(16, 1);
    changePeaceSelectedUser(18, 1);
    changePeaceSelectedUser(20, 1);
    changePeaceSelectedUser(22, 1);
    changePeaceSelectedUser(41, 2);
    changePeaceSelectedUser(43, 2);
    changePeaceSelectedUser(45, 2);
    changePeaceSelectedUser(47, 2);
    changePeaceSelectedUser(48, 2);
    changePeaceSelectedUser(50, 2);
    changePeaceSelectedUser(52, 2);
    changePeaceSelectedUser(54, 2);
    changePeaceSelectedUser(57, 2);
    changePeaceSelectedUser(59, 2);
    changePeaceSelectedUser(61, 2);
    changePeaceSelectedUser(63, 2);
  }

  bool isTargetPeaceEmpty(int rIndex, int cIndex) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == 0;
  }

  bool isTargetPeaceEnemy(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser != 0 &&
        peaces[index].value.selectedUser != gamerId;
  }

  List getRightPawnMove(int rIndex, int cIndex, int gamerId, int direction,
      {bool isMultiMove = false}) {
    int newRIndex = 0;
    int newCIndex = 0;
    if (direction == 1) {
      newRIndex = rIndex - 1;
      newCIndex = cIndex + 1;
    } else {
      newRIndex = rIndex + 1;
      newCIndex = cIndex - 1;
    }
    final nullResult = [null, null, null, false];
    if (newRIndex < 0 || newRIndex > 7 || newCIndex < 0 || newCIndex > 7) {
      return nullResult;
    }
    if (isTargetPeaceEmpty(newRIndex, newCIndex) && !isMultiMove) {
      return [
        [newRIndex, newCIndex],
        null,
        null,
        false
      ];
    } else {
      if (isTargetPeaceEnemy(newRIndex, newCIndex, gamerId)) {
        int newR1Index = 0;
        int newC1Index = 0;
        if (direction == 1) {
          newR1Index = newRIndex - 1;
          newC1Index = newCIndex + 1;
        } else {
          newR1Index = newRIndex + 1;
          newC1Index = newCIndex - 1;
        }
        if (newR1Index >= 0 &&
            newR1Index <= 7 &&
            newC1Index <= 7 &&
            newC1Index >= 0 &&
            isTargetPeaceEmpty(newR1Index, newC1Index)) {
          checkMoveList.add(
            [
              [newR1Index, newC1Index],
              [newRIndex, newCIndex],
              [rIndex, cIndex],
              true
            ],
          );
        }
        return nullResult;
      } else {
        return nullResult;
      }
    }
  }

  List getLeftPawnMove(int rIndex, int cIndex, int gamerId, int direction,
      {bool isMultiMove = false}) {
    int newRIndex = 0;
    int newCIndex = 0;
    if (direction == 1) {
      newRIndex = rIndex + 1;
      newCIndex = cIndex + 1;
    } else {
      newRIndex = rIndex - 1;
      newCIndex = cIndex - 1;
    }
    final nullResult = [null, null, null, false];
    if (newRIndex < 0 || newRIndex > 7 || newCIndex < 0 || newCIndex > 7) {
      return nullResult;
    }
    if (isTargetPeaceEmpty(newRIndex, newCIndex) && !isMultiMove) {
      return [
        [newRIndex, newCIndex],
        null,
        null,
        false
      ];
    } else {
      if (isTargetPeaceEnemy(newRIndex, newCIndex, gamerId)) {
        int newR1Index = 0;
        int newC1Index = 0;
        if (direction == 1) {
          newR1Index = newRIndex + 1;
          newC1Index = newCIndex + 1;
        } else {
          newR1Index = newRIndex - 1;
          newC1Index = newCIndex - 1;
        }
        if (newR1Index >= 0 &&
            newR1Index <= 7 &&
            newC1Index <= 7 &&
            newC1Index >= 0 &&
            isTargetPeaceEmpty(newR1Index, newC1Index)) {
          checkMoveList.add(
            [
              [newR1Index, newC1Index],
              [newRIndex, newCIndex],
              [rIndex, cIndex],
              true
            ],
          );
        }
        return nullResult;
      } else {
        return nullResult;
      }
    }
  }

  List getDirectionMovesList(
      int rIndex, int cIndex, int gamerId, int direction) {
    List<List> tempList = [];
    List rightResult = getRightPawnMove(rIndex, cIndex, gamerId, direction);
    List leftResult = getLeftPawnMove(rIndex, cIndex, gamerId, direction);
    tempList.add([rightResult[0], rightResult[1], rightResult[2]]);
    tempList.add([leftResult[0], leftResult[1], leftResult[2]]);
    // print(checkMoveList);
    while (checkMoveList.isNotEmpty) {
      List? indexes = checkMoveList[0][0];
      List? removedPeace = checkMoveList[0][1];
      List? sourceStart = checkMoveList[0][2];
      bool isMultiMove = checkMoveList[0][3];
      tempList.add([indexes, removedPeace, sourceStart]);
      if (removedPeace != null) {
        // print(checkMoveList[0]);
        rightResult = getRightPawnMove(
            indexes![0], indexes[1], gamerId, direction,
            isMultiMove: isMultiMove);
        leftResult = getLeftPawnMove(indexes[0], indexes[1], gamerId, direction,
            isMultiMove: isMultiMove);
        checkMoveList.add(rightResult);
        checkMoveList.add(leftResult);
        // print(checkMoveList);
      }
      checkMoveList.removeAt(0);
    }
    return tempList;
  }

  List getPossibleMovesOfPeace(int rIndex, int cIndex, int gamerId) {
    List tempList = [];
    List result = [];
    int index = coordinateToIndex(rIndex, cIndex);
    if (peaces[index].value.isSuperPawn) {
      final List list1 = getDirectionMovesList(rIndex, cIndex, gamerId, 1);
      final List list2 = getDirectionMovesList(rIndex, cIndex, gamerId, 2);
      tempList.addAll(list1);
      tempList.addAll(list2);
    } else if (gamerId == 1) {
      final List list1 = getDirectionMovesList(rIndex, cIndex, gamerId, 1);
      tempList.addAll(list1);
    } else {
      final List list1 = getDirectionMovesList(rIndex, cIndex, gamerId, 2);
      tempList.addAll(list1);
    }
    for (var dataRaw in tempList) {
      if (dataRaw[0] != null) {
        result.add(dataRaw);
      }
    }
    return result;
  }

  bool checkIsLastPeace(cIndex, gamerId) {
    if (gamerId == 1) {
      if (cIndex == 7) {
        return true;
      }
      return false;
    } else {
      if (cIndex == 0) {
        return true;
      }
      return false;
    }
  }

  void removePawn(int rIndex, int cIndex, int gamerId) {
    showInteraction(sound: GameSoundTypes.hit);
    int index = coordinateToIndex(rIndex, cIndex);
    changePeaceSelectedUser(index, 0);
    if (gamerId == 1) {
      player2Pawns.value -= 1;
    } else {
      player1Pawns.value -= 1;
    }
  }

  bool movePawn(int sourceCIndex, int sourceRIndex, int targetCIndex,
      int targetRIndex, int gamerId) {
    for (var moveData in currentPossibleMoves) {
      if (moveData[0] != null &&
          listEquals(moveData[0], [targetRIndex, targetCIndex])) {
        int sourceIndex = coordinateToIndex(sourceRIndex, sourceCIndex);
        int targetIndex = coordinateToIndex(targetRIndex, targetCIndex);
        if (checkIsLastPeace(targetCIndex, gamerId) ||
            peaces[sourceIndex].value.isSuperPawn) {
          changePeaceSelectedUser(targetIndex, gamerId, isSuperPawn: true);
        } else {
          changePeaceSelectedUser(targetIndex, gamerId, isSuperPawn: false);
        }
        changePeaceSelectedUser(sourceIndex, 0);

        if (moveData[1] != null) {
          List? removePoint = moveData[1];
          List sourcePeaceIndex = moveData[2];
          while (removePoint != null) {
            removePawn(removePoint[0], removePoint[1], gamerId);
            removePoint = null;
            for (var rawMoveData in currentPossibleMoves) {
              if (listEquals(
                  rawMoveData[0], [sourcePeaceIndex[0], sourcePeaceIndex[1]])) {
                removePoint = rawMoveData[1];
                sourcePeaceIndex = rawMoveData[2];
                break;
              }
            }
          }
        }
        return true;
      }
    }
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Checkers;
    initPeaces();
  }
}
