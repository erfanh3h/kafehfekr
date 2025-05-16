import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ludo/Models/ludo_piece_model.dart';
import 'package:refreshed/refreshed.dart';

Map<int, Map<int, Map<int, bool?>>> gamerPiecesWinMap = {
  1: {
    30: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    31: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    32: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    33: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    34: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    35: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  2: {
    12: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    13: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    14: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    15: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    16: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    17: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  3: {
    21: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    22: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    23: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    24: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    25: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    26: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
  4: {
    3: {1: false, 2: false, 3: false, 4: false, 5: false, 6: true},
    4: {1: false, 2: false, 3: false, 4: false, 5: true, 6: true},
    5: {1: false, 2: false, 3: false, 4: true, 5: true, 6: true},
    6: {1: false, 2: false, 3: true, 4: true, 5: true, 6: true},
    7: {1: false, 2: true, 3: true, 4: true, 5: true, 6: null},
    8: {1: true, 2: true, 3: true, 4: true, 5: null, 6: null}
  },
};

Map<int, Map<int, Map<int, int>>> gamerWinIndexesMap = {
  1: {
    30: {6: 36},
    31: {5: 36, 6: 37},
    32: {4: 36, 5: 37, 6: 38},
    33: {3: 36, 4: 37, 5: 38, 6: 39},
    34: {2: 36, 3: 37, 4: 38, 5: 39},
    35: {1: 36, 2: 37, 3: 38, 4: 39}
  },
  2: {
    12: {6: 40},
    13: {5: 40, 6: 41},
    14: {4: 40, 5: 41, 6: 42},
    15: {3: 40, 4: 41, 5: 42, 6: 43},
    16: {2: 40, 3: 41, 4: 42, 5: 43},
    17: {1: 40, 2: 41, 3: 42, 4: 43}
  },
  3: {
    21: {6: 44},
    22: {5: 44, 6: 45},
    23: {4: 44, 5: 45, 6: 46},
    24: {3: 44, 4: 45, 5: 46, 6: 47},
    25: {2: 44, 3: 45, 4: 46, 5: 47},
    26: {1: 44, 2: 45, 3: 46, 4: 47}
  },
  4: {
    3: {6: 48},
    4: {5: 48, 6: 49},
    5: {4: 48, 5: 49, 6: 50},
    6: {3: 48, 4: 49, 5: 50, 6: 51},
    7: {2: 48, 3: 49, 4: 50, 5: 51},
    8: {1: 48, 2: 49, 3: 50, 4: 51}
  },
};

Map<int, Map<int, Map<int, int>>> gamerInWinIndexesMap = {
  1: {
    36: {1: 37, 2: 38, 3: 39},
    37: {1: 38, 2: 39},
    38: {1: 39},
    39: {}
  },
  2: {
    40: {1: 41, 2: 42, 3: 43},
    41: {1: 42, 2: 43},
    42: {1: 43},
    43: {}
  },
  3: {
    44: {1: 45, 2: 46, 3: 47},
    45: {1: 46, 2: 47},
    46: {1: 47},
    47: {}
  },
  4: {
    48: {1: 49, 2: 50, 3: 51},
    49: {1: 50, 2: 41},
    50: {1: 51},
    51: {}
  },
};

class LudoController extends BaseGameController {
  RxList<Rx<LudoPieceModel>> peaces = RxList();
  RxList<Rx<LudoPieceModel>> startPieces = RxList();

  int playersCount = 2;

  RxList<int> playersOutPieces = RxList();

  RxInt currentDice = RxInt(0);
  RxBool currentTurnPlayerRolled = RxBool(false);
  RxBool hasMoreDice = RxBool(false);

  RxList<int> currentAvailableIndexes = RxList();

  @override
  void commandHandler(dynamic data) {
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.rollResult:
        rollResultFunction(data);
        break;
      case GameCommands.outOfMove:
        outOfMoveFunction(data);
        break;
      default:
    }
  }

  @override
  void currentTurnFunction(Map data) async {
    releasePeaces();
    int turn = data['data']['turn'];
    currentTurn.value = turn;
    currentTurnPlayerRolled.value = false;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.ludoTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map pieceData = data['data'];
    int index = pieceData['index'];
    int? targetIndex = pieceData['target_index'];
    int gamerId = pieceData['gamer_id'];
    String type = pieceData['type'];
    movePiece(index, targetIndex, gamerId, type);
    releasePeaces();
  }

  void rollResultFunction(Map data) {
    currentTurnPlayerRolled.value = true;
    Map turnData = data['data'];
    currentDice.value = turnData['dice'];
    showInteraction(sound: GameSoundTypes.dice);
    if (currentTurn.value == myGameId) {
      setAvailableMoves();
    }
  }

  void outOfMoveFunction(Map data) {
    currentTurnPlayerRolled.value = true;
    Map turnData = data['data'];
    int turn = turnData['turn'];
    currentDice.value = turnData['dice'];
    if (turn == myGameId) {
      canSelectPeace.value = false;
      showInteraction(
        sound: GameSoundTypes.tapWrong,
        text: AppTexts.youOutOfMove.tr,
      );
    } else {
      showInteraction(text: AppTexts.enemyOutOfMove.tr);
    }
    changetimerValue(GameWaitTimes.ludoOutOfMoveTime);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    List startBoardData = gameData['start_board'];
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
    for (var i = 0; i < startBoardData.length; i++) {
      if (startBoardData[i]['equipped_user'] == 0) {
        continue;
      }
      changeStartPieceSelectedUser(i, startBoardData[i]['equipped_user'],
          count: startBoardData[i]['count']);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
      if (currentTurnPlayerRolled.value) {
        setAvailableMoves();
      }
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.ludoTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    LudoPieceModel piece = tappedPeace as LudoPieceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if ((piece.selectedUser != null &&
            currentTurn.value != piece.selectedUser) ||
        piece.selectedUser == null ||
        !piece.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'index': piece.id}
    });
  }

  void onEachStartTap(dynamic tappedPeace) {
    LudoPieceModel piece = tappedPeace as LudoPieceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if ((piece.selectedUser != null &&
            currentTurn.value != piece.selectedUser) ||
        piece.selectedUser == null) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'index': -1}
    });
  }

  void onOutTap() {
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'index': -2}
    });
    releasePeaces();
  }

  bool checkWinIndexAvailable(int index) {
    final gamerId = peaces[index].value.selectedUser!;
    final isWinPieceTouchable =
        gamerInWinIndexesMap[gamerId]![index]!.keys.contains(currentDice.value);
    if (isWinPieceTouchable) {
      final targetIndex =
          gamerInWinIndexesMap[gamerId]![index]![currentDice.value]!;
      if (peaces[targetIndex].value.count == 0) {
        return true;
      }
    }
    return false;
  }

  bool checkIndexAvailable(int index) {
    final gamerId = peaces[index].value.selectedUser!;
    if (gamerId == 1 && index <= 29) {
      return true;
    }
    if (gamerId == 2 && (index <= 11 || index >= 18)) {
      return true;
    }
    if (gamerId == 3 && (index <= 20 || index >= 27)) {
      return true;
    }
    if (gamerId == 4 && (index <= 2 || index >= 9)) {
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
      bool mustAdd = false;
      if (pieceIndex >= 36) {
        //this check uses for win pieces
        mustAdd = checkWinIndexAvailable(pieceIndex);
      } else {
        mustAdd = checkIndexAvailable(pieceIndex);
      }
      if (mustAdd) {
        currentAvailableIndexes.add(pieceIndex);
        addPeaceStatus(pieceIndex, PeaceStatusTypes.canSelected);
      }
    }

    final havePieceOut = checkGamerPieceIsOut(currentTurn.value);
    if (havePieceOut && currentDice.value == 6) {
      currentAvailableIndexes.add(-1);
    }
    if (startPieces[currentTurn.value - 1].value.count != 0) {
      addStartPeaceStatus(currentTurn.value - 1, PeaceStatusTypes.canSelected);
    }
  }

  checkHitEnemy(int targetIndex, int gamerId) {
    //hit enemy
    if (peaces[targetIndex].value.isEnemySpot(gamerId)) {
      final enemyIndex = peaces[targetIndex].value.selectedUser!;
      final enemyCount = peaces[targetIndex].value.count;
      playersOutPieces[enemyIndex - 1] += enemyCount;
      peaces[targetIndex].value.resetPeace();
    }
  }

  movePiece(int index, int? targetIndex, int gamerId, String type) {
    if (type == "out") {
      playersOutPieces[gamerId - 1] -= 1;
      startPieces[gamerId - 1].value =
          startPieces[gamerId - 1].value.addPiece(gamerId);
      update();
    } else if (type == "start") {
      checkHitEnemy(targetIndex!, gamerId);
      reduceStartPiece(gamerId - 1);
      changePieceSelecteUser(targetIndex, gamerId);
      update();
    } else {
      checkHitEnemy(targetIndex!, gamerId);
      reducePiece(index);
      changePieceSelecteUser(targetIndex, gamerId);
      update();
    }
  }

  rollDice() {
    sendCommand({
      "id": GameCommands.rollDice,
      "data": {'dice': 0}
    });
  }

  void releasePeaces() {
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    currentAvailableIndexes.clear();
    currentTurnPlayerRolled.value = false;
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

  reducePiece(int index) {
    peaces[index].value = peaces[index].value.reducePiece();
  }

  reduceStartPiece(int index) {
    startPieces[index].value = startPieces[index].value.reducePiece();
  }

  changePieceSelecteUser(int index, int gamerId, {int? count}) {
    final newCount = count ?? (peaces[index].value.count + 1);
    peaces[index].value = peaces[index]
        .value
        .changeSelectedUser(newSelectedUser: gamerId, newCount: newCount);
  }

  changeStartPieceSelectedUser(int index, int gamerId, {int count = 1}) {
    startPieces[index].value = startPieces[index]
        .value
        .changeSelectedUser(newSelectedUser: gamerId, newCount: count);
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  addStartPeaceStatus(int peaceId, PeaceStatusTypes status) {
    startPieces.value[peaceId].value =
        startPieces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.removeStatus(status: status);
  }

  removeStartPeaceStatus(int peaceId, PeaceStatusTypes status) {
    startPieces.value[peaceId].value =
        startPieces.value[peaceId].value.removeStatus(status: status);
  }

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      peaces.value[i].value =
          peaces.value[i].value.removeStatus(status: status);
    }
    for (var i = 0; i < startPieces.length; i++) {
      startPieces.value[i].value =
          startPieces.value[i].value.removeStatus(status: status);
    }
  }

  initPieces() {
    for (var i = 0; i < 52; i++) {
      peaces.add(Rx(LudoPieceModel(id: i, currentStatuses: [])));
    }
    for (var i = 0; i < 4; i++) {
      startPieces.add(Rx(LudoPieceModel(id: i, currentStatuses: [])));
    }
    for (var i = 0; i < playersCount; i++) {
      startPieces.add(Rx(LudoPieceModel(id: i, currentStatuses: [])));
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
