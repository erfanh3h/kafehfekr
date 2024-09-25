import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Yinsh/Models/yinsh_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class YinshController extends BaseGameController {
  RxList<Rx<YinshPieceModel>> peaces = RxList();

  RxInt player1Peaces = RxInt(9);
  RxInt player2Peaces = RxInt(9);

  RxInt player1PlayedPeaces = RxInt(0);
  RxInt player2PlayedPeaces = RxInt(0);

  RxInt player1RemovedPeaces = RxInt(0);
  RxInt player2RemovedPeaces = RxInt(0);

  RxInt equippedPeaceIndex = RxInt(-1);

  RxInt currentRemover = RxInt(0);

  RxBool letRemovePeace = RxBool(false);

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
    changetimerValue(GameWaitTimes.millSelectTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    // int peaceId = peaceData['target_peace'];
    // int gamerId = peaceData['user'];
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

  @override
  // ignore: unnecessary_overrides
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    // Map newData = data['data'];
    // Map gameData = newData['game_data'];
    // Map timerData = newData['timer_data'];
    // List boardData = gameData['board'];
    // int currentRemoverGameId = gameData['current_remover'];
    // player1PlayedPeaces.value = gameData['played_peaces'][0];
    // player2PlayedPeaces.value = gameData['played_peaces'][1];
    // player1RemovedPeaces.value = gameData['removed_peaces'][0];
    // player2RemovedPeaces.value = gameData['removed_peaces'][1];
    // currentTurn.value = gameData['current_turn'];
    // currentRemover.value = gameData['current_remover'];
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
    // if (currentRemoverGameId == myGameId) {
    //   letRemovePeace.value = true;
    //   canSelectPeace.value = true;
    //   for (var neighborId in getEnemyPeacesIndexes()) {
    //     addPeaceStatus(neighborId, PeaceStatusTypes.canHitted);
    //   }
    // }
    // // if (timerData['is_user_turn']) {
    // final int time = GameWaitTimes.millSelectTime - timerData['time'] as int;
    // changetimerValue(time.clamp(0, time));
    // }
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
    for (var i = 0; i < 85; i++) {
      peaces.add(
        Rx(
          YinshPieceModel(id: i, currentStatuses: [], directions: []),
        ),
      );
    }
    // peaces.value[10].value =
    //     peaces.value[10].value.changeselectedDisk(newselectedDisk: 1);
    // peaces.value[34].value =
    //     peaces.value[34].value.changeselectedDisk(newselectedDisk: 2);
    // peaces.value[35].value =
    //     peaces.value[35].value.changeselectedRing(newselectedRing: 1);
    // peaces.value[25].value =
    //     peaces.value[25].value.changeselectedRing(newselectedRing: 2);
    // peaces.value[60].value =
    //     peaces.value[60].value.changeselectedRing(newselectedRing: 2);
    // peaces.value[60].value =
    //     peaces.value[60].value.changeselectedDisk(newselectedDisk: 2);
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Yinsh;
    initPieces();
  }
}
