import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Yatzy/Models/yatzy_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class YatzyController extends BaseGameController {
  RxList<Rx<YatzyPeaceModel>> player1Pieces = RxList();
  RxList<Rx<YatzyPeaceModel>> player2Pieces = RxList();

  RxList<int> currentDices = RxList([0, 0, 0, 0, 0]);
  RxList<int> selectedDicesIndexes = RxList([]);

  int equippedIndex = 0;

  RxInt remainingDice = RxInt(3);

  @override
  void commandHandler(dynamic data) {
    super.commandHandler(data);
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.rollResult:
        rollResultFunction(data);
        break;
      default:
    }
  }

  @override
  void currentTurnFunction(Map data) {
    resetRound();
    Map turnData = data['data'];
    currentTurn.value = turnData['current_turn'];
    currentDices.value = List<int>.from(turnData['dices']);
    canSelectPeace.value = true;
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    changetimerValue(GameWaitTimes.yatzyTurnTime);
    setFirstEmptyIndex();
    update();
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    currentRound.value = gameData['current_round'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_turn'];
    // for (var i = 0; i < boardData.length; i++) {
    //   if (boardData[i] == 0) {
    //     continue;
    //   }
    //   player1Pieces[i].value =
    //       player1Pieces[i].value.changeSelectedUser(score: boardData[i]);
    // }
    // if (currentTurn.value == myGameId) {
    //   canSelectPeace.value = true;
    // } else {
    //   canSelectPeace.value = false;
    // }
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.yatzyTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, time));
    }
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['target_peace'];
    // for (final peace in player1Pieces) {
    //   if (peace.value.id == peaceId) {
    //     peace.value = peace.value.changeSelectedUser(score: peaceData["user"]);
    //     removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
    //     break;
    //   }
    // }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    YatzyPeaceModel peace = tappedPeace as YatzyPeaceModel;
    // if (!canSelectPeace.value) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    // if (peace.gamerId != myGameId) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    if (peace.isSelected) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    if (equippedIndex != peace.id) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
      removePeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
      addPeaceStatus(peace.id, PeaceStatusTypes.equiped);
      equippedIndex = peace.id;
    }
    // canSelectPeace.value = false;
    // sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
  }

  void onEachDiceTapped(int index) {
    if (selectedDicesIndexes.value.contains(index)) {
      selectedDicesIndexes.value.remove(index);
      update();
    } else {
      selectedDicesIndexes.value.add(index);
      update();
    }
  }

  void rollResultFunction(Map data) {
    Map turnData = data['data'];
    currentDices.value = List<int>.from(turnData['dices']);
    update();
  }

  RxBool isDiceSelected(int index) {
    return RxBool(selectedDicesIndexes.value.contains(index));
  }

  void rollDice() {
    if (remainingDice.value == 0) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    remainingDice.value -= 1;
    sendCommand({
      "id": GameCommands.rollDice,
      "data": {
        "selected_indexes": selectedDicesIndexes.value,
      }
    });
  }

  void sendResult() {
    sendCommand({"id": GameCommands.selectPeace});
  }

  // void resetPeaces() {
  //   for (var i = 0; i < peaces.length; i++) {
  //     peaces[i].value = peaces[i].value.resetPeace();
  //   }
  // }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    if (myGameId == 1) {
      player1Pieces.value[peaceId].value =
          player1Pieces.value[peaceId].value.addStatus(status: status);
    } else {
      player2Pieces.value[peaceId].value =
          player2Pieces.value[peaceId].value.addStatus(status: status);
    }
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    if (myGameId == 1) {
      player1Pieces.value[peaceId].value =
          player1Pieces.value[peaceId].value.removeStatus(status: status);
    } else {
      player2Pieces.value[peaceId].value =
          player2Pieces.value[peaceId].value.removeStatus(status: status);
    }
  }

  void onEachRowTap(int index) {
    print(index);
  }

  setFirstEmptyIndex() {
    if (myGameId == 1) {
      for (var i = 0; i < player1Pieces.value.length; i++) {
        if (!player1Pieces.value[i].value.isSelected) {
          equippedIndex = i;
          addPeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
          return;
        }
      }
    } else {
      for (var i = 0; i < player2Pieces.value.length; i++) {
        if (!player2Pieces.value[i].value.isSelected) {
          equippedIndex = i;
          addPeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
          return;
        }
      }
    }
  }

  resetRound() {
    removePeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
    selectedDicesIndexes.value.clear();
    remainingDice.value = 3;
    equippedIndex = 0;
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.tictactoe;
    myGameId = 2;
    for (var i = 0; i < 12; i++) {
      player1Pieces
          .add(Rx(YatzyPeaceModel(id: i, currentStatuses: [], gamerId: 1)));
      player2Pieces
          .add(Rx(YatzyPeaceModel(id: i, currentStatuses: [], gamerId: 2)));
    }
  }
}
