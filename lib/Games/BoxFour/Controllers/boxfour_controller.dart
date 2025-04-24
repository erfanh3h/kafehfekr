import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/BoxFour/Models/boxfour_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class BoxFourController extends BaseGameController {
  RxList<Rx<BoxFourPeaceModel>> peaces = RxList();

  List currentPossibleMoves = [];

  List<(int, int)> moveDirs = [
    (-1, 0),
    (0, -1),
    (0, 1),
    (1, 0),
  ];

  List<int> indexToCoordinate(int index) {
    final x = index % 5;
    final y = index ~/ 5;
    return [x, y];
  }

  int coordinateToIndex(int y, int x) {
    final index = y * 5 + x;
    return index;
  }

  @override
  void currentTurnFunction(Map data) {
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      getLegalPieces();
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.boxFourTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data'];
    final rIndex = selectionData['r_index'];
    final cIndex = selectionData['c_index'];
    final int gamerId = selectionData['gamer_id'];
    final index = coordinateToIndex(cIndex, rIndex);
    submitPieceForUser((cIndex, rIndex), gamerId);
    removePeaceStatus(index, PeaceStatusTypes.isLoading);
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    player1Score.value = getPlayerScore(1);
    player2Score.value = getPlayerScore(2);
    removeAllPeacesStatus(PeaceStatusTypes.lastTurnPlayed);
    peaces.value[index].value = peaces.value[index].value
        .addStatus(status: PeaceStatusTypes.lastTurnPlayed);
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    BoxFourPeaceModel peace = tappedPeace as BoxFourPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    canSelectPeace.value = false;
    final List targetData = indexToCoordinate(peace.id);
    final rIndex = targetData[0];
    final cIndex = targetData[1];
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'c_index': cIndex, 'r_index': rIndex}
    });
    addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      getLegalPieces();
    } else {
      canSelectPeace.value = false;
    }
    final int time = GameWaitTimes.boxFourTurnTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, GameWaitTimes.boxFourTurnTime));
  }

  changePieceValue(int pieceId, int? selectedUser, int? value) {
    peaces.value[pieceId].value = peaces.value[pieceId].value
        .changeValue(newSelectedUser: selectedUser, newValue: value);
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

  initPieces() {
    for (var i = 0; i < 25; i++) {
      peaces.add(Rx(BoxFourPeaceModel(id: i, currentStatuses: [])));
    }
    changePieceValue(11, 1, 3);
    changePieceValue(13, 2, 3);
    player1Score.value = 1;
    player2Score.value = 1;
  }

  bool isTargetPeaceEmpty(int rIndex, int cIndex) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == 0;
  }

  bool isTargetPeaceForGamerId(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == gamerId;
  }

  bool isValidCoordinate(cIndex, rIndex) {
    if (rIndex >= 0 && rIndex <= 4 && cIndex >= 0 && cIndex <= 4) {
      return true;
    }
    return false;
  }

  getLegalPieces() {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.selectedUser == myGameId) {
        addPeaceStatus(i, PeaceStatusTypes.canSelected);
      }
    }
  }

  spreadNumber((int, int) position, int gamerId) {
    showInteraction(sound: GameSoundTypes.correct);
    int index = coordinateToIndex(position.$1, position.$2);
    changePieceValue(index, 0, 0);
    for (var directionMove in moveDirs) {
      int y = position.$1 + directionMove.$1;
      int x = position.$2 + directionMove.$2;
      if (isValidCoordinate(y, x)) {
        index = coordinateToIndex(y, x);
        int currentValue = peaces[index].value.value;
        if (currentValue < 3) {
          changePieceValue(index, gamerId, currentValue + 1);
        } else {
          spreadNumber((y, x), gamerId);
        }
      }
    }
  }

  submitPieceForUser((int, int) position, gamerId) {
    int index = coordinateToIndex(position.$1, position.$2);
    int currentValue = peaces[index].value.value;
    if (currentValue < 3) {
      changePieceValue(index, gamerId, currentValue + 1);
    } else {
      spreadNumber(position, gamerId);
    }
  }

  int getPlayerScore(int gamerId) {
    int count = 0;
    for (var piece in peaces) {
      if (piece.value.selectedUser == gamerId) {
        count += 1;
      }
    }
    return count;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.BoxFour;
    initPieces();
  }
}
