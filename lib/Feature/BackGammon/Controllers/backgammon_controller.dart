import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/BackGammon/Models/backgammon_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class BackGammonController extends BaseGameController {
  RxList<Rx<BackGammonPeaceModel>> peaces = RxList();

  RxInt equippedDiceIndex = RxInt(-1);
  RxList<int> currentDices = RxList([]);

  RxInt player1OutPieces = RxInt(0);
  RxInt player2OutPieces = RxInt(0);

  bool player1IsInEndPhase = false;
  bool player2IsInEndPhase = false;

  RxBool showDices = RxBool(false);
  @override
  void currentTurnFunction(Map data) {
    equippedDiceIndex.value = -1;
    showDices.value = false;
    clearCanSelectedStatus();
    Map turnData = data['data'];
    int turn = turnData['turn'];
    currentDices.value = List<int>.from(turnData['dices']);
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.backGammonTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map pieceData = data['data'];
    int gamerId = pieceData['gamer_id'];
    int index = pieceData['index'];
    int diceIndex = pieceData['dice_index'];
    movePiece(index, currentDices[diceIndex], gamerId);
    currentDices.removeAt(diceIndex);
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    BackGammonPeaceModel peace = tappedPeace as BackGammonPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (equippedDiceIndex.value == -1) {
      showInteraction(text: AppTexts.selectDiceFirst.tr);
      return;
    }

    if (checkPieceIsOut()) {
      if (!peaces[peace.id]
          .value
          .currentStatuses
          .contains(PeaceStatusTypes.canHitted)) {
        showInteraction(text: AppTexts.bringInOutedPiece.tr);
        return;
      }
      showInteraction(sound: GameSoundTypes.tap);
      int newIndex;
      if (myGameId == 1) {
        newIndex = -1;
      } else {
        newIndex = 24;
      }
      sendCommand({
        "id": GameCommands.selectPeace,
        "data": {'index': newIndex, 'dice_index': equippedDiceIndex.value}
      });
    } else {
      if (!peaces[peace.id]
          .value
          .currentStatuses
          .contains(PeaceStatusTypes.canSelected)) {
        showInteraction(text: AppTexts.cantSelect.tr);
        return;
      }
      showInteraction(sound: GameSoundTypes.tap);
      sendCommand({
        "id": GameCommands.selectPeace,
        "data": {'index': peace.id, 'dice_index': equippedDiceIndex.value}
      });
    }
    equippedDiceIndex.value = -1;
    clearCanSelectedStatus();
    if (currentDices.isEmpty) {
      canSelectPeace.value = false;
    }
  }

  void onEachDiceButtonTap(int index) {
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (equippedDiceIndex.value != -1) {
      if (index == equippedDiceIndex.value) {
        equippedDiceIndex.value = -1;
      } else {
        equippedDiceIndex.value = index;
      }
    } else {
      equippedDiceIndex.value = index;
    }
    setActivePossiblePieces();
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    List outPieces = gameData['out_pieces'];
    List endPhases = gameData['end_phases'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_turn'];
    player1OutPieces.value = outPieces[0];
    player2OutPieces.value = outPieces[1];
    player1IsInEndPhase = endPhases[0];
    player2IsInEndPhase = endPhases[1];
    currentDices.value = List<int>.from(gameData['current_dices']);
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time =
          GameWaitTimes.backGammonTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.backGammonTurnTime));
    }
  }

  bool checkPeaceIsEmpty(int index) {
    return peaces.value[index].value.selectedUser == 0;
  }

  bool checkPeaceIsEnemy(int index, {int? gamerId}) {
    return peaces.value[index].value.selectedUser != 0 &&
        peaces.value[index].value.selectedUser != (gamerId ?? myGameId);
  }

  changePeaceCount(int peaceId, int gamerId, int value) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changecount(newcount: value, newSelectedUser: gamerId);
  }

  reducePeaceCount(int peaceId) {
    int newValue = peaces.value[peaceId].value.count - 1;
    if (newValue == 0) {
      peaces.value[peaceId].value = peaces.value[peaceId].value
          .changecount(newcount: 0, newSelectedUser: 0);
    } else {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.changecount(newcount: newValue);
    }
  }

  addPeaceCount(int peaceId, int gamerId) {
    int newValue = peaces.value[peaceId].value.count + 1;
    if (newValue == 1) {
      peaces.value[peaceId].value = peaces.value[peaceId].value
          .changecount(newcount: newValue, newSelectedUser: gamerId);
    } else {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.changecount(newcount: newValue);
    }
  }

  changePeaceSelectedGamer(int? peaceId, int? value) {
    if (peaceId != null) {
      peaces.value[peaceId].value = peaces.value[peaceId].value
          .changeSelectedUser(newSelectedUser: value);
    }
  }

  changePeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  clearCanSelectedStatus() {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i]
          .value
          .currentStatuses
          .contains(PeaceStatusTypes.canSelected)) {
        peaces[i].value =
            peaces[i].value.removeStatus(status: PeaceStatusTypes.canSelected);
      }
      if (peaces[i]
          .value
          .currentStatuses
          .contains(PeaceStatusTypes.canHitted)) {
        peaces[i].value =
            peaces[i].value.removeStatus(status: PeaceStatusTypes.canHitted);
      }
    }
  }

  void initPieces() {
    for (var i = 0; i < 24; i++) {
      peaces.add(Rx(BackGammonPeaceModel(id: i, currentStatuses: [])));
    }
    changePeaceCount(0, 1, 2);
    changePeaceCount(23, 2, 2);
    changePeaceCount(5, 2, 5);
    changePeaceCount(18, 1, 5);
    changePeaceCount(7, 2, 3);
    changePeaceCount(16, 1, 3);
    changePeaceCount(11, 1, 5);
    changePeaceCount(12, 2, 5);
    // currentDices.value = [1, 2, 3, 5, 6, 4];
  }

  // check whether all pieces are in enf phaese
  checkGamerIsInEndPhase(int gamerId) {
    if (gamerId == 1) {
      if (peaces[18].value.count +
              peaces[19].value.count +
              peaces[20].value.count +
              peaces[21].value.count +
              peaces[22].value.count +
              peaces[23].value.count +
              player1Score.value ==
          15) {
        player1IsInEndPhase = true;
      } else {
        player1IsInEndPhase = false;
      }
    } else {
      if (peaces[0].value.count +
              peaces[1].value.count +
              peaces[2].value.count +
              peaces[3].value.count +
              peaces[4].value.count +
              peaces[5].value.count +
              player2Score.value ==
          15) {
        player2IsInEndPhase = true;
      } else {
        player2IsInEndPhase = false;
      }
    }
  }

  movePiece(int index, int dice, int gamerId) {
    //come piece from out
    if (index == -1 || index == 24) {
      if (gamerId == 1) {
        player1OutPieces.value -= 1;
      } else {
        player2OutPieces.value -= 1;
      }
    } else {
      reducePeaceCount(index);
    }
    int multiple = 1;
    if (gamerId == 2) {
      multiple = -1;
    }
    int targetIndex = index + (dice * multiple);
    bool isInEndPhase = false;
    // check whether all pieces are in enf phaese
    if (myGameId == 1 && player1IsInEndPhase) {
      isInEndPhase = true;
    } else if (myGameId == 2 && player2IsInEndPhase) {
      isInEndPhase = true;
    }
    if (isInEndPhase && (targetIndex == -1 || targetIndex == 24)) {
      if (gamerId == 1) {
        player1Score.value += 1;
      } else {
        player2Score.value += 1;
      }
    } else {
      if (checkPeaceIsEnemy(targetIndex, gamerId: gamerId)) {
        if (gamerId == 1) {
          player2OutPieces.value += 1;
        } else {
          player1OutPieces.value += 1;
        }
        reducePeaceCount(targetIndex);
      }
      addPeaceCount(targetIndex, gamerId);
    }
    checkGamerIsInEndPhase(gamerId);
  }

  bool checkPieceIsOut() {
    if (myGameId == 1 && player1OutPieces.value != 0) {
      return true;
    }
    if (myGameId == 2 && player2OutPieces.value != 0) {
      return true;
    }
    return false;
  }

  bool isValidIndex(int index) {
    if (index >= 0 && index < 24) {
      return true;
    }
    return false;
  }

  bool isValidIndexInEndPhase(int index, int gamerId) {
    if (gamerId == 1) {
      if (index >= 0 && index <= 24) {
        return true;
      }
    }
    if (gamerId == 2) {
      if (index >= -1 && index <= 24) {
        return true;
      }
    }
    return false;
  }

  bool checkSourceCanMoveNCount(int source, int count) {
    int multiple = 1;
    if (myGameId == 2) {
      multiple = -1;
    }
    int destination = source + (count * multiple);
    bool isInEndPhase = false;
    if (myGameId == 1 && player1IsInEndPhase) {
      isInEndPhase = true;
    } else if (myGameId == 2 && player2IsInEndPhase) {
      isInEndPhase = true;
    }
    if (isInEndPhase) {
      if (!isValidIndexInEndPhase(destination, myGameId)) {
        return false;
      }
      if (destination != -1 &&
          destination != 24 &&
          checkPeaceIsEnemy(destination) &&
          peaces.value[destination].value.count > 1) {
        return false;
      }
    } else {
      if (!isValidIndex(destination)) {
        return false;
      }
      if (checkPeaceIsEnemy(destination) &&
          peaces.value[destination].value.count > 1) {
        return false;
      }
    }

    return true;
  }

  List<int> getMyPiecesList() {
    List<int> result = [];
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.selectedUser == myGameId) {
        result.add(i);
      }
    }
    return result;
  }

  setActivePossiblePieces() {
    clearCanSelectedStatus();
    if (equippedDiceIndex.value == -1) {
      return;
    }
    if (checkPieceIsOut()) {
      int multiple = 1;
      int source = -1;
      if (myGameId == 2) {
        multiple = -1;
        source = 24;
      }
      int destination =
          source + (currentDices[equippedDiceIndex.value] * multiple);
      if (!checkPeaceIsEnemy(destination)) {
        changePeaceStatus(destination, PeaceStatusTypes.canHitted);
      } else {
        if (peaces.value[destination].value.count <= 1) {
          changePeaceStatus(destination, PeaceStatusTypes.canHitted);
        }
      }
    } else {
      List<int> myIndexes = getMyPiecesList();
      for (var index in myIndexes) {
        if (checkSourceCanMoveNCount(
            index, currentDices[equippedDiceIndex.value])) {
          changePeaceStatus(index, PeaceStatusTypes.canSelected);
        }
      }
    }
  }

  letShowDices() {
    showDices.value = true;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.backGammon;
    initPieces();
  }
}
