import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class DotBoxController extends BaseGameController {
  RxList<Rx<DotBoxPeaceModel>> linePeaces = RxList();
  RxList<Rx<DotBoxPeaceModel>> boxPeaces = RxList();

  Map<int, List<int>> boxNeighborsData = {
    0: [0, 5, 6, 11],
    1: [1, 6, 7, 12],
    2: [2, 7, 8, 13],
    3: [3, 8, 9, 14],
    4: [4, 9, 10, 15],
    5: [11, 16, 17, 22],
    6: [12, 17, 18, 23],
    7: [13, 18, 19, 24],
    8: [14, 19, 20, 25],
    9: [15, 20, 21, 26],
    10: [22, 27, 28, 33],
    11: [23, 28, 29, 34],
    12: [24, 29, 30, 35],
    13: [25, 30, 31, 36],
    14: [26, 31, 32, 37],
    15: [33, 38, 39, 44],
    16: [34, 39, 40, 45],
    17: [35, 40, 41, 46],
    18: [36, 41, 42, 47],
    19: [37, 42, 43, 48],
    20: [44, 49, 50, 55],
    21: [45, 50, 51, 56],
    22: [46, 51, 52, 57],
    23: [47, 52, 53, 58],
    24: [48, 53, 54, 59],
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
    changetimerValue(GameWaitTimes.dotBoxTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['target_peace'];
    int gamerId = peaceData['user'];
    changeLinePeaceSelectedUser(peaceId, gamerId);
    final result = checkBoxWinHappen(peaceId);
    if (result[0]) {
      for (var index in result[1]) {
        changeBoxPeaceSelectedUser(index, gamerId);
      }
      if (gamerId == 1) {
        player1Score += result[0].length;
      } else {
        player2Score += result[1].length;
      }
    }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List linesBoardData = gameData['lines_board'];
    List boxesBoardData = gameData['boxes_board'];
    currentTurn.value = gameData['current_turn'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    for (var i = 0; i < linesBoardData.length; i++) {
      changeLinePeaceSelectedUser(i, linesBoardData[i]);
    }
    for (var i = 0; i < boxesBoardData.length; i++) {
      changeBoxPeaceSelectedUser(i, boxesBoardData[i]);
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

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    DotBoxPeaceModel peace = tappedPeace as DotBoxPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    //TODO : check prevent selected piece select again
    canSelectPeace.value = false;
    showInteraction(sound: GameSoundTypes.tap);
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
  }

  bool checkEachBoxInRawHappen(List<int> neighbors) {
    for (var neighbor in neighbors) {
      int? value = linePeaces[neighbor].value.selectedUser;
      if (value == 0) {
        return false;
      }
    }
    return true;
  }

  List<dynamic> checkBoxWinHappen(int peaceNumber) {
    Map<int, List<int>> linesListToCheck = {};
    bool isWinHappen = false;
    List<int> winResult = [];
    boxNeighborsData.forEach((index, neighbors) {
      if (neighbors.contains(peaceNumber)) {
        linesListToCheck[index] = neighbors;
      }
    });
    linesListToCheck.forEach((index, neighbors) {
      if (checkEachBoxInRawHappen(neighbors)) {
        isWinHappen = true;
        winResult.add(index);
      }
    });
    return [isWinHappen, winResult];
  }

  bool checkPeaceIsEmpty(int index) {
    return linePeaces.value[index].value.selectedUser == null;
  }

  void resetPeaces() {
    for (var i = 0; i < linePeaces.length; i++) {
      linePeaces[i].value = linePeaces[i].value.resetPeace();
    }
    for (var i = 0; i < boxPeaces.length; i++) {
      boxPeaces[i].value = boxPeaces[i].value.resetPeace();
    }
  }

  changeLinePeaceSelectedUser(int? peaceId, int number) {
    if (peaceId != null) {
      linePeaces.value[peaceId].value = linePeaces.value[peaceId].value
          .changeSelectedUser(newSelectedUser: number);
    }
  }

  changeBoxPeaceSelectedUser(int? peaceId, int number) {
    if (peaceId != null) {
      boxPeaces.value[peaceId].value = boxPeaces.value[peaceId].value
          .changeSelectedUser(newSelectedUser: number);
    }
  }

  addLinePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      linePeaces.value[peaceId].value =
          linePeaces.value[peaceId].value.addStatus(status: status);
    }
  }

  removeLinePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      linePeaces.value[peaceId].value =
          linePeaces.value[peaceId].value.removeStatus(status: status);
    }
  }

  addBoxPeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      boxPeaces.value[peaceId].value =
          boxPeaces.value[peaceId].value.addStatus(status: status);
    }
  }

  removeBoxPeaceStatus(int? peaceId, PeaceStatusTypes status) {
    if (peaceId != null) {
      boxPeaces.value[peaceId].value =
          boxPeaces.value[peaceId].value.removeStatus(status: status);
    }
  }

  removeAllPeacesStatus(PeaceStatusTypes status) {
    for (var i = 0; i < linePeaces.length; i++) {
      linePeaces.value[i].value =
          linePeaces.value[i].value.removeStatus(status: status);
    }
    for (var i = 0; i < boxPeaces.length; i++) {
      boxPeaces.value[i].value =
          boxPeaces.value[i].value.removeStatus(status: status);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.dotbox;
    for (var i = 0; i < 60; i++) {
      linePeaces.add(Rx(DotBoxPeaceModel(
        id: i,
        currentStatuses: [],
        selectedUser: 0,
      )));
    }
    for (var i = 0; i < 25; i++) {
      boxPeaces.add(Rx(DotBoxPeaceModel(
        id: i,
        currentStatuses: [],
        selectedUser: 0,
      )));
    }
  }
}
