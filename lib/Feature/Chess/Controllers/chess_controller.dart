import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Checkers/Models/checkers_peace_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class ChessController extends BaseGameController {
  RxList<Rx<ChessPieceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(16);
  RxInt player2Pawns = RxInt(16);

  RxInt equippedPeaceIndex = RxInt(-1);

  List checkMoveList = [];
  List currentPossibleMoves = [];

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
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.checkersTurnTime);
    releasePeace();
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final sourceRIndex = selectionData['s_r_index'];
    final sourceCIndex = selectionData['s_c_index'];
    final targetRIndex = selectionData['t_r_index'];
    final targetCIndex = selectionData['t_c_index'];
    final int gamerId = selectionData['gamer_id'];
    final index = coordinateToIndex(sourceRIndex, sourceCIndex);
    addPossibleMoves(index);
    final moveResult = movePawn(
        sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, gamerId);
    if (moveResult) {
      releasePeace();
    }
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
      peaces[i].value = peaces[i].value.getFromJson(boardData[i], i);
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
    CheckersPeaceModel peace = tappedPeace as CheckersPeaceModel;
    if (!canSelectPeace.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    // if (peace.selectedUser == null) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    // canSelectPeace.value = false;
    // sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
    // addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    // Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
    // if (peace.selectedUser != myGameId) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    if (equippedPeaceIndex.value != -1) {
      if (equippedPeaceIndex.value == peace.id) {
        releasePeace();
      } else if (peace.selectedUser == myGameId) {
        releasePeace();
        equipPeace(peace.id);
      } else {
        if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
          Get.find<SoundPlayerComponent>()
              .playGameSound(GameSoundTypes.tapWrong);
          return;
        }
        final List sourceData = indexToCoordinate(equippedPeaceIndex.value);
        final sourceRIndex = sourceData[0];
        final sourceCIndex = sourceData[1];
        final List targetData = indexToCoordinate(peace.id);
        final targetRIndex = targetData[0];
        final targetCIndex = targetData[1];
        sendCommand({
          "id": GameCommands.selectPeace,
          "data": {
            's_c_index': sourceCIndex,
            's_r_index': sourceRIndex,
            't_c_index': targetCIndex,
            't_r_index': targetRIndex,
          }
        });
        releasePeace();
        // final moveResult = movePawn(
        //     sourceCIndex, sourceRIndex, targetCIndex, targetRIndex, myGameId);
        // if (moveResult) {
        //   releasePeace();
        // }
      }
    } else {
      if (peace.selectedUser != 0 && peace.selectedUser == myGameId) {
        equipPeace(peace.id);
      }
    }
  }

  void equipPeace(int index) {
    equippedPeaceIndex.value = index;
    addPeaceStatus(index, PeaceStatusTypes.equiped);
    addPossibleMoves(index);
  }

  void releasePeace() {
    try {
      removePeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    } catch (_) {}
    removeAllPeacesStatus(PeaceStatusTypes.canSelected);
    equippedPeaceIndex.value = -1;
    currentPossibleMoves.clear();
  }

  void addPossibleMoves(int index) {
    List coordinates = indexToCoordinate(index);
    List movesPossibleList =
        getPossibleMovesOfPeace(coordinates[0], coordinates[1], myGameId);
    for (var dataRaw in movesPossibleList) {
      List? coordinates = dataRaw[0];
      if (coordinates != null) {
        final peaceId = coordinateToIndex(coordinates[0], coordinates[1]);
        addPeaceStatus(peaceId, PeaceStatusTypes.canSelected);
        currentPossibleMoves.add(dataRaw);
      }
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  changePeaceSelectedUser(int peaceId, int? selectedUser, {bool? isSuperPawn}) {
    peaces.value[peaceId].value = peaces.value[peaceId].value
        .changeSelectedUser(
            newSelectedUser: selectedUser, newIsSuperPawn: isSuperPawn);
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
          Rx(ChessPieceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
    // changePeaceSelectedUser(0, 1);
  }

  bool isTargetPeaceEmpty(int rIndex, int cIndex) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == 0;
  }

  bool isTargetPeaceEnemy(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser != gamerId;
  }

  List getDirectionMovesList(
      int rIndex, int cIndex, int gamerId, int direction) {
    List<List> tempList = [];
    return tempList;
  }

  List getPossibleMovesOfPeace(int rIndex, int cIndex, int gamerId) {
    List tempList = [];
    List result = [];
    int index = coordinateToIndex(rIndex, cIndex);
    return result;
  }

  bool checkIsLastPeace(cIndex, gamerId) {
    if (gamerId == 1) {
      if (cIndex == 7) {
        return true;
      }
      return false;
    } else {
      if (cIndex == 0) {
        return true;
      }
      return false;
    }
  }

  void removePawn(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    changePeaceSelectedUser(index, 0);
    if (gamerId == 1) {
      player2Pawns.value -= 1;
    } else {
      player1Pawns.value -= 1;
    }
  }

  bool movePawn(int sourceCIndex, int sourceRIndex, int targetCIndex,
      int targetRIndex, int gamerId) {
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.chess;
    initPeaces();
  }
}
