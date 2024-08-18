import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Othello/Models/othello_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class OthelloController extends BaseGameController {
  RxList<Rx<OthelloPeaceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(30);
  RxInt player2Pawns = RxInt(30);

  List currentPossibleMoves = [];

  List<List<int>> moveDirs = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ];

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
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
      final moves = getLegalMoves(myGameId);
      for (var move in moves) {
        int row = move[0];
        int col = move[1];
        int index = coordinateToIndex(row, col);
        addPeaceStatus(index, PeaceStatusTypes.canSelected);
      }
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.othelloTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final rIndex = selectionData['r_index'];
    final cIndex = selectionData['c_index'];
    final int gamerId = selectionData['gamer_id'];
    List<int> scores = List<int>.from(data['data']['scores']);
    if (gamerId == 1) {
      player1Pawns.value -= 1;
    } else {
      player2Pawns.value -= 1;
    }
    final index = coordinateToIndex(rIndex, cIndex);
    removePeaceStatus(index, PeaceStatusTypes.isLoading);
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    flitTiles(gamerId, [rIndex, cIndex]);
    player1Score.value = scores[0];
    player2Score.value = scores[1];
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    OthelloPeaceModel peace = tappedPeace as OthelloPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
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
    player1Pawns.value = gameData['pawns_count'][0];
    player2Pawns.value = gameData['pawns_count'][1];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    for (var i = 0; i < boardData.length; i++) {
      changePeaceSelectedUser(i, boardData[i]);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.millSelectTime));
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  changePeaceSelectedUser(int peaceId, int? selectedUser) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changeSelectedUser(newSelectedUser: selectedUser);
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
          Rx(OthelloPeaceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
    changePeaceSelectedUser(27, 1);
    changePeaceSelectedUser(36, 1);
    changePeaceSelectedUser(28, 2);
    changePeaceSelectedUser(35, 2);
    player1Score.value = 2;
    player2Score.value = 2;
  }

  bool isTargetPeaceEmpty(int rIndex, int cIndex) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == 0;
  }

  bool isTargetPeaceEnemy(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser != gamerId;
  }

  bool isTargetPeaceForGamerId(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == gamerId;
  }

  bool isValidCoordinate(rIndex, cIndex) {
    if (rIndex >= 0 && rIndex <= 7 && cIndex >= 0 && cIndex <= 7) {
      return true;
    }
    return false;
  }

  bool hasTileToFlip(List<int> move, List<int> direction, gamerId) {
    int i = 1;
    if (isValidCoordinate(move[0], move[1])) {
      while (true) {
        int row = move[0] + direction[0] * i;
        int col = move[1] + direction[1] * i;
        int index = coordinateToIndex(row, col);
        if (!isValidCoordinate(row, col) || isTargetPeaceEmpty(row, col)) {
          return false;
        } else if (peaces[index].value.selectedUser == gamerId) {
          break;
        } else {
          i += 1;
        }
      }
    }
    return i > 1;
  }

  void flitTiles(int gamerId, List<int> move) {
    int index = coordinateToIndex(move[0], move[1]);
    changePeaceSelectedUser(index, gamerId);
    for (var direction in moveDirs) {
      if (hasTileToFlip(move, direction, gamerId)) {
        int i = 1;
        while (true) {
          int row = move[0] + direction[0] * i;
          int col = move[1] + direction[1] * i;
          int index = coordinateToIndex(row, col);
          if (isTargetPeaceForGamerId(row, col, gamerId)) {
            break;
          } else {
            changePeaceSelectedUser(index, gamerId);
            i += 1;
          }
        }
      }
    }
  }

  bool hasLegalMove(int gamerId) {
    for (var row = 0; row < 8; row++) {
      for (var col = 0; col < 8; col++) {
        final move = [row, col];
        if (isLegalMove(move, gamerId)) {
          return true;
        }
      }
    }
    return false;
  }

  List<List<int>> getLegalMoves(int gamerId) {
    List<List<int>> moves = [];
    for (var row = 0; row < 8; row++) {
      for (var col = 0; col < 8; col++) {
        final move = [row, col];
        if (isLegalMove(move, gamerId)) {
          moves.add(move);
        }
      }
    }
    return moves;
  }

  bool isLegalMove(List<int>? move, int gamerId) {
    if (move != null &&
        isValidCoordinate(move[0], move[1]) &&
        isTargetPeaceEmpty(move[0], move[1])) {
      for (var direction in moveDirs) {
        if (hasTileToFlip(move, direction, gamerId)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.othello;
    initPeaces();
  }
}
