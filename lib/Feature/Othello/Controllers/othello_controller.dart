import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Othello/Models/othello_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class OthelloController extends BaseGameController {
  RxList<Rx<OthelloPeaceModel>> peaces = RxList();
  RxInt player1Pawns = RxInt(12);
  RxInt player2Pawns = RxInt(12);

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
    changetimerValue(GameWaitTimes.othelloTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map selectionData = data['data']['select_data'];
    final rIndex = selectionData['r_index'];
    final cIndex = selectionData['c_index'];
    final index = coordinateToIndex(rIndex, cIndex);
    removePeaceStatus(index, PeaceStatusTypes.isLoading);
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    OthelloPeaceModel peace = tappedPeace as OthelloPeaceModel;
    if (!canSelectPeace.value) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (!peace.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
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
          Rx(OthelloPeaceModel(id: i, currentStatuses: [], selectedUser: 0)));
    }
    changePeaceSelectedUser(27, 1);
    changePeaceSelectedUser(36, 1);
    changePeaceSelectedUser(28, 2);
    changePeaceSelectedUser(35, 2);
  }

  bool isTargetPeaceEmpty(int rIndex, int cIndex) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser == 0;
  }

  bool isTargetPeaceEnemy(int rIndex, int cIndex, int gamerId) {
    int index = coordinateToIndex(rIndex, cIndex);
    return peaces[index].value.selectedUser != gamerId;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.othello;
    initPeaces();
  }
}
