import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/MNumbers/Models/mnumbers_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersController extends BaseGameController {
  RxList<Rx<MNumbersPeaceModel>> peaces = RxList();

  RxInt equippedPeaceIndex = RxInt(-1);

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
    changetimerValue(GameWaitTimes.mnumbersTurnTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int gamerId = peaceData['user'];
    bool isCorrectlySelected = peaceData['is_correct'];
    int index1 = peaceData['index1'];
    int index2 = peaceData['index2'];
    int value1 = peaceData['value1'];
    int value2 = peaceData['value2'];
    changetimerValue(GameWaitTimes.mnumbersShowResultTime);
    removePeaceStatus(index1, PeaceStatusTypes.isLoading);
    removePeaceStatus(index2, PeaceStatusTypes.isLoading);
    clearEquipStatus();
    addPeaceStatus(index1, PeaceStatusTypes.selected);
    changePeaceValue(index1, value1);
    changePeaceSelectedGamer(index1, gamerId);
    addPeaceStatus(index2, PeaceStatusTypes.selected);
    changePeaceValue(index2, value2);
    changePeaceSelectedGamer(index2, gamerId);
    if (isCorrectlySelected) {
      if (gamerId == 1) {
        player1Score.value += 1;
      } else {
        player2Score.value += 1;
      }
    } else {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        removePeaceStatus(index1, PeaceStatusTypes.selected);
        changePeaceValue(index1, null);
        changePeaceSelectedGamer(index1, null);
        removePeaceStatus(index2, PeaceStatusTypes.selected);
        changePeaceValue(index2, null);
        changePeaceSelectedGamer(index2, null);
      });
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    MNumbersPeaceModel peace = tappedPeace as MNumbersPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (!checkPeaceIsEmpty(peace.id)) {
      showInteraction(text: AppTexts.selectedBefore.tr);
      return;
    }
    if (equippedPeaceIndex.value != -1) {
      if (peace.id == equippedPeaceIndex.value) {
        equippedPeaceIndex.value = -1;
        removePeaceStatus(peace.id, PeaceStatusTypes.equiped);
        return;
      }
      canSelectPeace.value = false;
      showInteraction(sound: GameSoundTypes.tap);
      changetimerValue(0);
      currentTurn.value = -1;
      sendCommand({
        "id": GameCommands.selectPeace,
        "data": {'index1': equippedPeaceIndex.value, 'index2': peace.id}
      });
      addPeaceStatus(peace.id, PeaceStatusTypes.equiped);
      addPeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.isLoading);
      addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
      equippedPeaceIndex.value = -1;
    } else {
      equippedPeaceIndex.value = peace.id;
      showInteraction(sound: GameSoundTypes.tap);
      addPeaceStatus(equippedPeaceIndex.value, PeaceStatusTypes.equiped);
    }
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_turn'];
    for (var i = 0; i < boardData.length; i++) {
      if (boardData[i]['value'] == 0) {
        continue;
      }
      if (boardData[i]['equipped_user'] != 0) {
        changePeaceValue(i, boardData[i]['value']);
        changePeaceSelectedGamer(i, boardData[i]['equipped_user']);
      }
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    if (timerData['is_user_turn']) {
      final int time =
          GameWaitTimes.mnumbersTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.mnumbersTurnTime));
    }
  }

  bool checkPeaceIsEmpty(int index) {
    return peaces.value[index].value.selectedUser == null;
  }

  void clearEquipedPeace(int index) {
    equippedPeaceIndex.value = -1;
    removePeaceStatus(index, PeaceStatusTypes.equiped);
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

  changePeaceValue(int? peaceId, int? value) {
    if (peaceId != null) {
      peaces.value[peaceId].value =
          peaces.value[peaceId].value.changeValue(newValue: value);
    }
  }

  changePeaceSelectedGamer(int? peaceId, int? value) {
    if (peaceId != null) {
      peaces.value[peaceId].value = peaces.value[peaceId].value
          .changeSelectedUser(newSelectedUser: value);
    }
  }

  clearEquipStatus() {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.currentStatuses.contains(PeaceStatusTypes.equiped)) {
        peaces[i].value =
            peaces[i].value.removeStatus(status: PeaceStatusTypes.equiped);
      }
    }
  }

  initPieces() {
    for (var i = 0; i < 36; i++) {
      peaces.add(Rx(MNumbersPeaceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.MNumbers;
    initPieces();
  }
}
