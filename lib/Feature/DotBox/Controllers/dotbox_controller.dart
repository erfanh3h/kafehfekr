import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';
import 'package:kafehfekr/Feature/Mill/Models/mill_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class DotBoxController extends BaseGameController {
  RxList<Rx<DotBoxPeaceModel>> linePeaces = RxList();
  RxList<Rx<DotBoxPeaceModel>> boxPeaces = RxList();

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
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.millSelectTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['target_peace'];
    int gamerId = peaceData['user'];
    // if (gamerId == 1) {
    //   player1PlayedPeaces.value += 1;
    // } else {
    //   player2PlayedPeaces.value += 1;
    // }
    // for (final peace in peaces) {
    //   if (peace.value.id == peaceId) {
    //     peace.value = peace.value.changeSelectedUser(newSelectedUser: gamerId);
    //     removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    //     break;
    //   }
    // }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentTurn.value = gameData['current_turn'];
    // for (var i = 0; i < boardData.length; i++) {
    //   if (boardData[i] == 0) {
    //     continue;
    //   }
    //   peaces[i].value =
    //       peaces[i].value.changeSelectedUser(newSelectedUser: boardData[i]);
    // }
    // if (currentTurn.value == myGameId) {
    //   canSelectPeace.value = true;
    // } else {
    //   canSelectPeace.value = false;
    // }
    // if (timerData['is_user_turn']) {
    //   final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
    //   changetimerValue(time.clamp(1, GameWaitTimes.millSelectTime));
    // }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    MillPeaceModel peace = tappedPeace as MillPeaceModel;
    if (!canSelectPeace.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    addLinePeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
  }


  bool checkSelectedPeaceIsNeighborOfSource(int targetId) {
    return (neighborsData[0] ?? []).contains(targetId);
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
      linePeaces.add(Rx(DotBoxPeaceModel(id: i, currentStatuses: [])));
    }
    for (var i = 0; i < 25; i++) {
      boxPeaces.add(Rx(DotBoxPeaceModel(id: i, currentStatuses: [])));
    }
  }
}
