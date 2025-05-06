import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Sudoku/Models/sudoku_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class SudokuOfflineController extends BaseOfflineGameController {
  RxList<Rx<SudokuPeaceModel>> peaces = RxList();

  RxInt selectedNumber = RxInt(1);

  RxMap eachNumbersCount =
      RxMap({1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0});

  void commandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.wrongSolve:
        wrongSolveFunction(data);
        break;
      default:
    }
  }

  void startGameFunction(Map data) {
    Map pieceData = data['data'];
    List boardData = pieceData['board'];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = SudokuPeaceModel.fromJson(boardData[i], i);
    }
    showInteraction(sound: GameSoundTypes.startGame);
    getCountOfNumbers();
  }

  void wrongSolveFunction(data) {
    DialogComponent().showDialog(AppTexts.error.tr, AppTexts.errorSolve.tr);
  }

  Color? returnTimerColor() {
    return null;
  }

  void selectPeaceResult(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['piece_id'];
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.changeValue(newValue: peaceData["number"]);
    addPeaceStatus(peaceId, PeaceStatusTypes.selected);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
  }

  void playerScoreFunction(Map data) {
    Map scoreData = data['data'];
    int score = scoreData['value'];
    int gamerId = scoreData['gamer_id'];
    if (gamerId == 1) {
      player1Score.value = score;
    } else {
      player2Score.value = score;
    }
  }

  void onEachButtonTap(dynamic tappedPeace) {
    SudokuPeaceModel peace = tappedPeace as SudokuPeaceModel;
    if (peace.isBaseNumber) {
      showInteraction(text: AppTexts.cantSelect.tr);
      return;
    }
    if (selectedNumber.value != 0 &&
        eachNumbersCount[selectedNumber.value] == 9) {
      showInteraction(
          sound: GameSoundTypes.tapWrong, text: AppTexts.outOfThisNumber.tr);
      return;
    }
    if (selectedNumber.value == 0) {
      if (peace.value != 0) {
        showInteraction(sound: GameSoundTypes.tap);
        changePeaceValue(peace.id, 0);
        getCountOfNumbers();
        return;
      } else {
        showInteraction(text: AppTexts.selectNumber.tr);
        return;
      }
    }
    showInteraction(sound: GameSoundTypes.tap);
    if (selectedNumber.value == peace.value) {
      changePeaceValue(peace.id, 0);
    } else {
      changePeaceValue(peace.id, selectedNumber.value);
    }
    getCountOfNumbers();
  }

  changeSelectedNumber(int number) {
    if (number == selectedNumber.value) {
      selectedNumber.value = 0;
    } else {
      selectedNumber.value = number;
    }
  }

  void resetPeaces() {
    for (var i = 0; i < peaces.length; i++) {
      peaces[i].value = peaces[i].value.resetPeace();
    }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.addStatus(status: status);
  }

  changePeaceValue(int peaceId, int number) {
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.changeValue(newValue: number);
  }

  removePeaceStatus(int? peaceId, PeaceStatusTypes status) {
    for (var i = 0; i < peaces.length; i++) {
      if (peaces[i].value.id == peaceId) {
        peaces.value[i].value =
            peaces.value[i].value.removeStatus(status: status);
        break;
      }
    }
  }

  solveFunction() {
    for (var piece in peaces.value) {
      if (piece.value.value == 0) {
        showInteraction(text: AppTexts.fillAllPieces.tr);
        return;
      }
    }
    sendCommand({"id": GameCommands.solve});
  }

  void getCountOfNumbers() {
    eachNumbersCount =
        RxMap({1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0});
    for (var i = 0; i < 81; i++) {
      if (peaces[i].value.value != 0) {
        eachNumbersCount[peaces[i].value.value] =
            eachNumbersCount[peaces[i].value.value] + 1;
      }
    }
    update();
  }

  initPieces() {
    for (var i = 0; i < 81; i++) {
      peaces.add(
        Rx(SudokuPeaceModel(id: i, currentStatuses: [])),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Sudoku;
    initPieces();
  }
}
