import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Yinsh/Controllers/directions.dart';
import 'package:kafehfekr/Games/Yinsh/Models/yinsh_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class YinshController extends BaseGameController {
  RxList<Rx<YinshPieceModel>> peaces = RxList();

  RxInt player1Rings = RxInt(5);
  RxInt player2Rings = RxInt(5);

  RxInt remainingDisks = RxInt(51);

  RxInt equippedPeaceIndex = RxInt(-1);

  RxBool isSetupRingPhase = RxBool(true);
  RxBool isRingSubmited = RxBool(false);

  List<int> directionsList = [1, 2, 3, 4, 5, 6];

  RxInt lastSelectedPieceId = RxInt(-1);

  @override
  void commandHandler(dynamic data) {
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.ringMoved:
        ringMovedFunction(data);
        break;
      case GameCommands.ringSubmited:
        ringSubmitedFunction(data);
        break;
      case GameCommands.removePeace:
        removePiecefunction(data);
        break;
      case GameCommands.winHappened:
        winHappenedfunction(data);
        break;
      default:
    }
  }

  @override
  void currentTurnFunction(Map data) {
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    removeAllPeacesStatus(PeaceStatusTypes.canHitted);
    lastSelectedPieceId.value = -1;
    Map turnData = data['data'];
    int turn = turnData['turn'];
    bool phase = turnData['is_setup_ring_phase'];
    isSetupRingPhase.value = phase;
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      if (isSetupRingPhase.value) {
        highlightEmptyRings();
      } else {
        getListOfPossibleRings(myGameId);
      }
    } else {
      canSelectPeace.value = false;
    }
    if (isSetupRingPhase.value) {
      changetimerValue(GameWaitTimes.yinshRingTime);
    } else {
      changetimerValue(GameWaitTimes.yinshTurnTime);
    }
  }

  @override
  void peaceSelectedFunction(Map data) {
    removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    Map peaceData = data['data'];
    int peaceId = peaceData['piece_id'];
    int gamerId = peaceData['gamer_id'];
    remainingDisks.value -= 1;
    peaces[peaceId].value =
        peaces[peaceId].value.changeselectedDisk(newselectedDisk: gamerId);
    showInteraction(sound: GameSoundTypes.tapButton);
    peaces[peaceId].value = peaces[peaceId]
        .value
        .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
    // removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    // removeAllPeacesStatus(PeaceStatusTypes.isLoading);
    // peaces.value[peaceId].value = peaces.value[peaceId].value
    //     .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
  }

  @override
  void waitTimeFunction(Map data) {
    super.waitTimeFunction(data);
    currentTurn.value = 0;
  }

  @override
  // ignore: unnecessary_overrides
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    player1Score.value = gameData['player1_score'];
    player2Score.value = gameData['player2_score'];
    player1Rings.value = gameData['player1_rings'];
    player2Rings.value = gameData['player2_rings'];
    lastSelectedPieceId.value = gameData['last_selected_piece_id'];
    currentTurn.value = gameData['current_turn'];
    isSetupRingPhase.value = gameData['is_setup_ring_phase'];
    remainingDisks.value = gameData['disk_count'];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.changeDiskRing(
          newDisk: boardData[i]['disk_user'],
          newRing: boardData[i]['ring_user']);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      if (isSetupRingPhase.value) {
        highlightEmptyRings();
      } else {
        getListOfPossibleRings(myGameId);
      }
    } else {
      canSelectPeace.value = false;
    }
    if (isSetupRingPhase.value) {
      final int time = GameWaitTimes.yinshRingTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    } else {
      final int time = GameWaitTimes.yinshTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    YinshPieceModel peace = tappedPeace as YinshPieceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (isSetupRingPhase.value) {
      if (!peace.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
        showInteraction(text: AppTexts.cantSelect.tr);
        return;
      }
      canSelectPeace.value = false;
      sendCommand({"id": GameCommands.submitRing, "data": peace.id});
    } else {
      if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected) &&
          !peace.currentStatuses.contains(PeaceStatusTypes.canHitted)) {
        showInteraction(text: AppTexts.cantSelect.tr);
        return;
      }
      if (lastSelectedPieceId.value == -1) {
        lastSelectedPieceId.value = peace.id;
        removeAllPeacesStatus(PeaceStatusTypes.canSelected);
        getListOfPossibleSelections(peace.id);
        sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
      } else {
        canSelectPeace.value = false;
        // List<int> rotationsList = getListOfRotations(peace.id, myGameId);
        sendCommand({
          "id": GameCommands.moveRing,
          "data": {'target_id': peace.id}
        });
      }
    }

    // sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
  }

  void ringMovedFunction(Map data) {
    Map peaceData = data['data'];
    int sourceId = peaceData['source_id'];
    int peaceId = peaceData['target_id'];
    int gamerId = peaceData['gamer_id'];

    List<int> rotationsList = List<int>.from(peaceData['rotations_list']);
    moveRingToTarget(sourceId, peaceId, rotationsList, gamerId);

    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    removeAllPeacesStatus(PeaceStatusTypes.canHitted);
    // if (gamerId == 1) {
    //   player1PlayedPeaces.value += 1;
    // } else {
    //   player2PlayedPeaces.value += 1;
    // }
    // removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    // removeAllPeacesStatus(PeaceStatusTypes.isLoading);
    // peaces[peaceId].value =
    //     peaces[peaceId].value.changeSelectedUser(newSelectedUser: gamerId);
    // peaces.value[peaceId].value = peaces.value[peaceId].value
    //     .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
  }

  void ringSubmitedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['piece_id'];
    int gamerId = peaceData['gamer_id'];
    if (gamerId == 1) {
      player1Rings.value -= 1;
    } else {
      player2Rings.value -= 1;
    }
    // removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    removeAllPeacesStatus(PeaceStatusTypes.isLoading);
    peaces[peaceId].value =
        peaces[peaceId].value.changeselectedRing(newselectedRing: gamerId);
    // peaces.value[peaceId].value = peaces.value[peaceId].value
    //     .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
  }

  void removePiecefunction(Map data) {
    removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    Map peaceData = data['data'];
    int peaceId = peaceData['piece_id'];
    peaces[peaceId].value =
        peaces[peaceId].value.changeselectedDisk(newselectedDisk: null);
    lastSelectedPieceId.value = -1;
    remainingDisks.value += 1;
  }

  void winHappenedfunction(Map data) {
    Map peaceData = data['data'];
    List<Map> winData = List<Map>.from(peaceData['win_data']);
    List<int> removedRingsList = List<int>.from(peaceData['removed_rings']);
    if (winData.isNotEmpty) {
      for (var winRaw in winData) {
        List<int> removeDiskList = List<int>.from(winRaw['data']);
        // int gamerId = winRaw['gamer_id'];
        for (var pieceId in removeDiskList) {
          peaces[pieceId].value =
              peaces[pieceId].value.changeselectedDisk(newselectedDisk: null);
          remainingDisks.value += 1;
        }
      }
      for (var ringId in removedRingsList) {
        final gamerId = peaces[ringId].value.selectedRing;
        if (gamerId != null) {
          if (gamerId == 1) {
            player1Score.value += 1;
          } else {
            player2Score.value += 1;
          }
          peaces[ringId].value =
              peaces[ringId].value.changeselectedRing(newselectedRing: null);
        }
      }
    }
  }

  void getListOfPossibleRings(int gamerId) {
    for (var peace in peaces.value) {
      if (peace.value.selectedRing == gamerId) {
        addPeaceStatus(peace.value.id, PeaceStatusTypes.canSelected);
      }
    }
  }

  (int, int)? checkPieceHaveNeighbourInDirection(
      int directionId, int startPieceId) {
    (int, int)? result;
    for (var direction in peaces[startPieceId].value.directions) {
      if (direction.$1 == directionId) {
        if (peaces[direction.$2].value.selectedRing != null) {
          result = null;
        } else {
          result = direction;
        }
        break;
      }
    }
    return result;
  }

  List<int> getDirectionIdies(int directionId, int startPieceId) {
    List checkMoveList = [];
    List<int> result = [];
    (int, int)? haveNeighbour =
        checkPieceHaveNeighbourInDirection(directionId, startPieceId);
    if (haveNeighbour != null) {
      result.add(haveNeighbour.$2);
      checkMoveList.add(haveNeighbour.$2);
    }
    while (checkMoveList.isNotEmpty) {
      (int, int)? haveNeighbour =
          checkPieceHaveNeighbourInDirection(directionId, checkMoveList.first);
      if (haveNeighbour != null) {
        result.add(haveNeighbour.$2);
        checkMoveList.add(haveNeighbour.$2);
      }
      checkMoveList.removeAt(0);
    }
    return result;
  }

  void getListOfPossibleSelections(int pieceId) {
    Map<int, List<int>> result = {};
    for (var directionId in directionsList) {
      result[directionId] = getDirectionIdies(directionId, pieceId);
    }
    for (var directionId in result.keys) {
      for (var pId in result[directionId]!) {
        if (peaces[pId].value.selectedDisk == null) {
          addPeaceStatus(pId, PeaceStatusTypes.canHitted);
        } else {
          // this check uses for when ring pass through disk and must just select piece next after it
          final index = result[directionId]!.indexOf(pId);
          if (index != result[directionId]!.length) {
            for (var i = index; i < result[directionId]!.length; i++) {
              if (peaces[result[directionId]![i]].value.selectedDisk == null) {
                addPeaceStatus(
                    result[directionId]![i], PeaceStatusTypes.canHitted);
                break;
              }
            }
          }
          break;
        }
      }
    }
  }

  List<int> getListOfRotations(int pieceId, int gamerId) {
    Map<int, List<int>> result = {};
    for (var directionId in directionsList) {
      // print(getDirectionIdies(directionId, pieceId));
      result[directionId] =
          getDirectionIdies(directionId, lastSelectedPieceId.value);
    }
    int targetDirectionId = 1;
    for (var directionId in result.keys) {
      for (var pId in result[directionId]!) {
        if (peaces[pId].value.id == pieceId) {
          targetDirectionId = directionId;
          break;
        }
      }
    }
    List<int> finalResult = [];
    for (var pId in result[targetDirectionId]!) {
      if (peaces[pId].value.selectedDisk != null) {
        finalResult.add(pId);
      }
    }
    return finalResult;
  }

  void moveRingToTarget(
      int sourceId, int pieceId, List<int> rotationsList, int gamerId) {
    for (var pId in rotationsList) {
      if (peaces[pId].value.selectedDisk != null) {
        if (peaces[pId].value.selectedDisk == 1) {
          peaces[pId].value =
              peaces[pId].value.changeselectedDisk(newselectedDisk: 2);
        } else {
          peaces[pId].value =
              peaces[pId].value.changeselectedDisk(newselectedDisk: 1);
        }
      }
    }
    peaces[sourceId].value =
        peaces[sourceId].value.changeselectedRing(newselectedRing: null);
    peaces[pieceId].value =
        peaces[pieceId].value.changeselectedRing(newselectedRing: gamerId);
  }

  void highlightEmptyRings() {
    for (var i = 0; i < 85; i++) {
      if (peaces[i].value.selectedRing == null) {
        peaces[i].value =
            peaces[i].value.addStatus(status: PeaceStatusTypes.canHitted);
      }
    }
  }

  void changePeaceDisk(int peaceId, int? userId) {
    peaces[peaceId].value =
        peaces[peaceId].value.changeselectedDisk(newselectedDisk: userId);
  }

  void changePeaceRing(int peaceId, int? userId) {
    peaces[peaceId].value =
        peaces[peaceId].value.changeselectedRing(newselectedRing: userId);
  }

  void addPeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.addStatus(status: status);
    }
  }

  void removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.removeStatus(status: status);
    }
  }

  void removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
  }

  void initPieces() {
    for (var i = 0; i < 85; i++) {
      peaces.add(
        Rx(
          YinshPieceModel(
            id: i,
            currentStatuses: [],
            directions: allPieceDirections[i],
          ),
        ),
      );
    }
    // changePeaceRing(20, 1);
    // changePeaceDisk(42, 1);
    // changePeaceDisk(41, 1);
    // changePeaceDisk(40, 2);
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Yinsh;
    initPieces();
  }
}
