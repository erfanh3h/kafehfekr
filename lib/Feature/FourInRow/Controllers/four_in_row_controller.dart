import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/FourInRow/Models/four_in_row_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class FourInRowController extends BaseGameController {
  RxList<Rx<FourInRowPeaceModel>> pieces = RxList();
  RxInt player1Pawns = RxInt(32);
  RxInt player2Pawns = RxInt(32);

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
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.fourInRowTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final rIndex = selectionData['r_index'];
    final cIndex = selectionData['c_index'];
    final int gamerId = selectionData['gamer_id'];
    if (gamerId == 1) {
      player1Pawns.value -= 1;
    } else {
      player2Pawns.value -= 1;
    }
    final index = coordinateToIndex(rIndex, cIndex);
    changePeaceSelectedUser(index, gamerId);
  }

  void onSelectionTap(int rowIndex) {
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (!checkRowIsValid(rowIndex)) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": {'r_index': rowIndex}
    });
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
      changePeaceSelectedUser(i, boardData[i]);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time =
          GameWaitTimes.fourInRowTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.fourInRowTurnTime));
    }
  }

  changePeaceSelectedUser(int peaceId, int? selectedUser) {
    pieces.value[peaceId].value = pieces.value[peaceId].value
        .changeSelectedUser(newSelectedUser: selectedUser);
  }

  initPeaces() {
    for (var i = 0; i < 64; i++) {
      pieces.add(
          Rx(FourInRowPeaceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
  }

  bool checkRowIsValid(int rowIndex) {
    for (var i = 0; i < 8; i++) {
      int pieceId = coordinateToIndex(rowIndex, i);
      if (pieces.value[pieceId].value.selectedUser == 0) {
        return true;
      }
    }
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.fourInRow;
    initPeaces();
  }
}
