import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ludo/Models/ludo_piece_model.dart';
import 'package:refreshed/refreshed.dart';

Map<int, Map<int, Map<int, bool?>>> gamerPiecesWinMap = {
  1: {
    34: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    35: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    36: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    37: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    38: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    39: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  2: {
    14: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    15: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    16: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    17: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    18: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    19: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  3: {
    24: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    25: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    26: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    27: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    28: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    29: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  4: {
    4: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    5: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    6: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    7: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    8: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    9: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
};

Map<int, Map<int, Map<int, int>>> gamerWinIndexesMap = {
  1: {
    34: {6: 40},
    35: {5: 40, 6: 41},
    36: {4: 40, 5: 41, 6: 42},
    37: {3: 40, 4: 41, 5: 42, 6: 43},
    38: {2: 40, 3: 41, 4: 42, 5: 43},
    39: {1: 40, 2: 41, 3: 42, 4: 43}
  },
  2: {
    14: {6: 44},
    15: {5: 44, 6: 45},
    16: {4: 44, 5: 45, 6: 46},
    17: {3: 44, 4: 45, 5: 46, 6: 47},
    18: {2: 44, 3: 45, 4: 46, 5: 47},
    19: {1: 44, 2: 45, 3: 46, 4: 47}
  },
  3: {
    24: {6: 48},
    25: {5: 48, 6: 49},
    26: {4: 48, 5: 49, 6: 50},
    27: {3: 48, 4: 49, 5: 50, 6: 51},
    28: {2: 48, 3: 49, 4: 50, 5: 51},
    29: {1: 48, 2: 49, 3: 50, 4: 51}
  },
  4: {
    4: {6: 52},
    5: {5: 52, 6: 53},
    6: {4: 52, 5: 53, 6: 54},
    7: {3: 52, 4: 53, 5: 54, 6: 55},
    8: {2: 52, 3: 53, 4: 54, 5: 55},
    9: {1: 52, 2: 53, 3: 54, 4: 55}
  },
};

class LudoController extends BaseGameController {
  RxList<Rx<LudoPieceModel>> peaces = RxList();

  int playersCount = 2;

  RxList<int> playersOutPieces = RxList();

  RxInt currentDice = RxInt(0);
  RxBool currentTurnPlayerRolled = RxBool(false);
  RxBool hasMoreDice = RxBool(false);

  RxList<int> currentAvailableIndexes = RxList();

  @override
  void commandHandler(dynamic data) {
    print(data);
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.rollResult:
        rollResultFunction(data);
        break;
      default:
    }
  }

  @override
  void currentTurnFunction(Map data) {
    releasePeaces();
    int turn = data['data']['turn'];
    currentTurn.value = turn;
    currentTurnPlayerRolled.value = false;
    // if (turn == myGameId) {
    canSelectPeace.value = true;
    showInteraction(sound: GameSoundTypes.startTurn);
    // } else {
    //   canSelectPeace.value = false;
    // }
    // changetimerValue(GameWaitTimes.millSelectTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map pieceData = data['data'];
    int index = pieceData['index'];
    int gamerId = pieceData['gamer_id'];
    movePiece(index, gamerId);
    releasePeaces();
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    currentDice.value = gameData['current_dice'];
    currentTurnPlayerRolled.value = gameData['current_turn_player_rolled'];
    playersOutPieces.value = List<int>.from(gameData['players_out_pieces']);
    for (var i = 0; i < boardData.length; i++) {
      if (boardData[i]['equipped_user'] == 0) {
        continue;
      }
      changePieceSelecteUser(i, boardData[i]['equipped_user'],
          count: boardData[i]['count']);
    }
    // if (currentTurn.value == myGameId) {
    canSelectPeace.value = true;
    if (currentTurnPlayerRolled.value) {
      setAvailableMoves();
    }
    // } else {
    //   canSelectPeace.value = false;
    // }
    // if (timerData['is_user_turn']) {
    // final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
    // changetimerValue(time.clamp(0, time));
    // }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    LudoPieceModel piece = tappedPeace as LudoPieceModel;
    // if (!canSelectPeace.value) {
    //   showInteraction(text: AppTexts.notYourTurn.tr);
    //   return;
    // }
    if ((piece.selectedUser != null &&
            currentTurn.value != piece.selectedUser) ||
        piece.selectedUser == null) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'index': piece.id}
    });
  }

  void onOutTap() {
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'index': -1}
    });
    releasePeaces();
  }

  bool checkIndexAvailable(int index) {
    final gamerId = peaces[index].value.selectedUser!;
    if (gamerId == 1 && index <= 33) {
      return true;
    }
    if (gamerId == 2 && (index <= 13 || index >= 20)) {
      return true;
    }
    if (gamerId == 3 && (index <= 23 || index >= 30)) {
      return true;
    }
    if (gamerId == 4 && (index <= 3 || index >= 10)) {
      return true;
    }
    final isIndexWinable =
        gamerPiecesWinMap[gamerId]![index]![currentDice.value];
    if (isIndexWinable == null) {
      return false;
    }
    if (isIndexWinable) {
      final winIndex = gamerWinIndexesMap[gamerId]![index]![currentDice.value]!;
      if (peaces[winIndex].value.selectedUser == null) {
        return true;
      }
      return false;
    }

    return true;
  }

  List<int> getMyPieceIndexes(gamerId) {
    List<int> result = [];
    for (var i = 0; i < (peaces.length); i++) {
      if (peaces[i].value.selectedUser == gamerId) {
        result.add(i);
      }
    }

    return result;
  }

  bool checkGamerPieceIsOut(int gamerId) {
    if (playersOutPieces.value[gamerId - 1] > 0) {
      return true;
    }
    return false;
  }

  setAvailableMoves() {
    final List<int> pieces = getMyPieceIndexes(currentTurn.value);
    for (var pieceIndex in pieces) {
      if (checkIndexAvailable(pieceIndex)) {
        currentAvailableIndexes.add(pieceIndex);
        addPeaceStatus(pieceIndex, PeaceStatusTypes.canSelected);
      }
    }

    final havePieceOut = checkGamerPieceIsOut(currentTurn.value);
    if (havePieceOut) {
      currentAvailableIndexes.add(-1);
    }
  }

  movePiece(int index, int gamerId) {
    int targetIndex = 0;
    if (index == -1) {
      if (gamerId == 1) {
        targetIndex = currentDice.value;
      } else if (gamerId == 2) {
        targetIndex = 20 + currentDice.value;
      } else if (gamerId == 3) {
        targetIndex = 30 + currentDice.value;
      } else if (gamerId == 4) {
        targetIndex = 10 + currentDice.value;
      }
      playersOutPieces[gamerId - 1] -= 1;
    } else if ((gamerId == 1 && index <= 33) ||
        (gamerId == 2 && (index <= 13 || index >= 20)) ||
        (gamerId == 3 && (index <= 23 || index >= 30)) ||
        (gamerId == 4 && (index <= 3 || index >= 10))) {
      targetIndex = (index + currentDice.value) % 40;
    } else {
      final isIndexWinable =
          gamerPiecesWinMap[gamerId]![index]![currentDice.value];
      if (isIndexWinable == null) {
      } else if (isIndexWinable) {
        targetIndex = gamerWinIndexesMap[gamerId]![index]![currentDice.value]!;
      } else {
        targetIndex = (index + currentDice.value) % 40;
      }
    }

    if (targetIndex < 40) {
      if ((gamerId != 1 && targetIndex == 0) ||
          (gamerId != 2 && targetIndex == 20) ||
          (gamerId != 3 && targetIndex == 30) ||
          (gamerId != 4 && targetIndex == 1)) {
        targetIndex += 1;
      } //other players cant enter others home
      if (peaces[targetIndex].value.isEnemySpot(gamerId)) {
        final enemyIndex = peaces[targetIndex].value.selectedUser!;
        final enemyCount = peaces[targetIndex].value.count;
        playersOutPieces[enemyIndex] += enemyCount;
        peaces[targetIndex].value.resetPeace();
      } //hit enemy
    } // win not happens
    removePiece(index);
    changePieceSelecteUser(targetIndex, gamerId);
    update();
  }

  rollDice() {
    sendCommand({
      "id": GameCommands.rollDice,
      "data": {'dice': 6}
    });
  }

  void rollResultFunction(Map data) {
    currentTurnPlayerRolled.value = true;
    Map turnData = data['data'];
    currentDice.value = turnData['dice'];
    showInteraction(sound: GameSoundTypes.dice);
    setAvailableMoves();
  }

  void releasePeaces() {
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
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

  removePiece(int index) {
    peaces[index].value = peaces[index].value.resetPeace();
  }

  changePieceSelecteUser(int index, int gamerId, {int count = 1}) {
    peaces[index].value = peaces[index]
        .value
        .changeSelectedUser(newSelectedUser: gamerId, newCount: count);
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
    for (var i = 0; i < 56; i++) {
      peaces.add(Rx(LudoPieceModel(id: i, currentStatuses: [])));
    }
    for (var i = 0; i < playersCount; i++) {
      playersOutPieces.add(4);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Ludo;
    initPieces();
    isPageLoading.value = false;
  }
}
