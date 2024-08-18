import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Yatzy/Models/yatzy_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class YatzyController extends BaseGameController {
  RxList<Rx<YatzyPeaceModel>> player1Pieces = RxList();
  RxList<Rx<YatzyPeaceModel>> player2Pieces = RxList();

  RxList<int> currentDices = RxList([0, 0, 0, 0, 0]);
  RxList<int> selectedDicesIndexes = RxList([]);

  int equippedIndex = 0;

  RxInt remainingDice = RxInt(3);

  RxBool isRoundPlayed = RxBool(false);

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
    calculateScores();
    showInteraction(sound: GameSoundTypes.startTurn);
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
    List player1BoardData = gameData['player1_board'];
    List player2BoardData = gameData['player2_board'];
    for (var i = 0; i < player1BoardData.length; i++) {
      player1Pieces[i].value =
          player1Pieces[i].value.fromJson(data: player1BoardData[i]);
    }
    for (var i = 0; i < player2BoardData.length; i++) {
      player2Pieces[i].value =
          player2Pieces[i].value.fromJson(data: player2BoardData[i]);
    }
    isRoundPlayed.value = gameData['is_round_done'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    currentTurn.value = gameData['current_round'];
    remainingDice.value = 3 - gameData['rolled_dice_times'] as int;
    currentDices.value = List<int>.from(gameData['current_dices']);
    calculateScores();
    setFirstEmptyIndex();
    update();
    if (timerData['is_user_turn']) {
      final int time = GameWaitTimes.yatzyTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, time));
    }
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map peaceData = data['data'];
    int gamerId = peaceData['gamer_id'];
    int selectedIndex = peaceData['selected_index'];
    int score = peaceData['score'];
    player1Score.value = peaceData['player1_score'];
    player2Score.value = peaceData['player2_score'];
    if (gamerId == 1) {
      player1Pieces.value[selectedIndex].value = player1Pieces
          .value[selectedIndex].value
          .changeSelectedUser(score: score);
    } else {
      player2Pieces.value[selectedIndex].value = player2Pieces
          .value[selectedIndex].value
          .changeSelectedUser(score: score);
    }
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
    if (isRoundPlayed.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (peace.isSelected) {
      showInteraction(text: AppTexts.selectedBefore.tr);
      return;
    }
    if (equippedIndex != peace.id) {
      showInteraction(sound: GameSoundTypes.tap);
      removePeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
      addPeaceStatus(peace.id, PeaceStatusTypes.equiped);
      equippedIndex = peace.id;
    }
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
    calculateScores();
    update();
  }

  RxBool isDiceSelected(int index) {
    return RxBool(selectedDicesIndexes.value.contains(index));
  }

  void rollDice() {
    if (remainingDice.value == 0) {
      showInteraction(text: AppTexts.outOfDice.tr);
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
    isRoundPlayed.value = true;
    sendCommand(
      {
        "id": GameCommands.selectPeace,
        "data": {"index": equippedIndex}
      },
    );
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
    DialogComponent().showToast(label: index.toString());
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

  changePlayerCalculatedScore(score, index) {
    if (myGameId == 1) {
      player1Pieces.value[index].value = player1Pieces.value[index].value
          .changeCalculatedScore(newScore: score);
    } else {
      player2Pieces.value[index].value = player2Pieces.value[index].value
          .changeCalculatedScore(newScore: score);
    }
  }

  resetCalculatedValues() {
    for (var i = 0; i < player1Pieces.length; i++) {
      player1Pieces.value[i].value =
          player1Pieces.value[i].value.changeCalculatedScore(newScore: 0);
    }
    for (var i = 0; i < player2Pieces.length; i++) {
      player2Pieces.value[i].value =
          player2Pieces.value[i].value.changeCalculatedScore(newScore: 0);
    }
  }

  resetRound() {
    removePeaceStatus(equippedIndex, PeaceStatusTypes.equiped);
    resetCalculatedValues();
    selectedDicesIndexes.value.clear();
    remainingDice.value = 3;
    equippedIndex = 0;
    isRoundPlayed.value = false;
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  int calculateSimpleDices(int number) {
    int calculatedScore = 0;
    for (var dice in currentDices.value) {
      if (dice == number) {
        calculatedScore += number;
      }
    }
    return calculatedScore;
  }

  bool calculateRepeatness(int number, int count) {
    int counter = 0;
    for (var dice in currentDices.value) {
      if (dice == number) {
        counter += 1;
      }
    }
    return counter >= count;
  }

  int calculateAllDices() {
    int calculatedScore = 0;
    for (var dice in currentDices.value) {
      calculatedScore += dice;
    }
    return calculatedScore;
  }

  calculate3TimesRepeat() {
    int calculatedScore = 0;
    for (var i = 1; i <= 6; i++) {
      if (calculateRepeatness(i, 3)) {
        calculatedScore += calculateAllDices();
        break;
      }
    }
    changePlayerCalculatedScore(calculatedScore, 6);
  }

  calculate4TimesRepeat() {
    int calculatedScore = 0;
    for (var i = 1; i <= 6; i++) {
      if (calculateRepeatness(i, 4)) {
        calculatedScore += calculateAllDices();
        break;
      }
    }
    changePlayerCalculatedScore(calculatedScore, 7);
  }

  bool calculate23TimesRepeat() {
    bool is2TimesExists = false;
    int threeTimesIndex = -1;
    bool is3TimesExists = false;
    for (var i = 1; i <= 6; i++) {
      if (calculateRepeatness(i, 3)) {
        is3TimesExists = true;
        threeTimesIndex = i;
        break;
      }
    }
    if (is3TimesExists) {
      for (var i = 1; i <= 6; i++) {
        if (calculateRepeatness(i, 2) && i != threeTimesIndex) {
          is2TimesExists = true;
          break;
        }
      }
    }
    return is2TimesExists && is3TimesExists;
  }

  bool calculate15Exists() {
    if (currentDices.contains(1) &&
        currentDices.contains(2) &&
        currentDices.contains(3) &&
        currentDices.contains(4) &&
        currentDices.contains(5)) {
      return true;
    }
    if (currentDices.contains(2) &&
        currentDices.contains(3) &&
        currentDices.contains(4) &&
        currentDices.contains(5) &&
        currentDices.contains(6)) {
      return true;
    }
    return false;
  }

  calculate5TimesRepeat() {
    for (var i = 1; i <= 6; i++) {
      if (calculateRepeatness(i, 5)) {
        changePlayerCalculatedScore(50, 11);
        return;
      }
    }
    changePlayerCalculatedScore(0, 11);
  }

  calculateScores() {
    changePlayerCalculatedScore(calculateSimpleDices(1), 0);
    changePlayerCalculatedScore(calculateSimpleDices(2), 1);
    changePlayerCalculatedScore(calculateSimpleDices(3), 2);
    changePlayerCalculatedScore(calculateSimpleDices(4), 3);
    changePlayerCalculatedScore(calculateSimpleDices(5), 4);
    changePlayerCalculatedScore(calculateSimpleDices(6), 5);
    calculate3TimesRepeat();
    calculate4TimesRepeat();
    changePlayerCalculatedScore(calculateAllDices(), 8);
    if (calculate23TimesRepeat()) {
      changePlayerCalculatedScore(25, 9);
    } else {
      changePlayerCalculatedScore(0, 9);
    }
    if (calculate15Exists()) {
      changePlayerCalculatedScore(40, 10);
    } else {
      changePlayerCalculatedScore(0, 10);
    }
    calculate5TimesRepeat();
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.yatzy;
    myGameId = 2;
    for (var i = 0; i < 12; i++) {
      player1Pieces
          .add(Rx(YatzyPeaceModel(id: i, currentStatuses: [], gamerId: 1)));
      player2Pieces
          .add(Rx(YatzyPeaceModel(id: i, currentStatuses: [], gamerId: 2)));
    }
  }
}
