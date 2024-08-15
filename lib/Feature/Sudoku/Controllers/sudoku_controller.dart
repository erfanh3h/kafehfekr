import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Sudoku/Models/sudoku_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class SudokuController extends BaseGameController {
  RxList<Rx<SudokuPeaceModel>> peaces = RxList();

  RxInt selectedNumber = RxInt(1);

  @override
  void startGameFunction(Map data) {
    Map pieceData = data['data'];
    List boardData = pieceData['board'];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = SudokuPeaceModel.fromJson(boardData[i], i);
    }
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startGame);
    canSelectPeace.value = true;
    changetimerValue(GameWaitTimes.sudokuGameTime);
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  @override
  void selectPeaceResult(Map data) {
    Map peaceData = data['data'];
    int peaceId = peaceData['piece_id'];
    peaces.value[peaceId].value =
        peaces.value[peaceId].value.changeValue(newValue: peaceData["number"]);
    addPeaceStatus(peaceId, PeaceStatusTypes.selected);
    removePeaceStatus(peaceId, PeaceStatusTypes.isLoading);
  }

  @override
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

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List boardData = gameData['board'];
    for (var i = 0; i < boardData.length; i++) {
      peaces[i].value = SudokuPeaceModel.fromJson(boardData[i], i);
    }
    final int time = GameWaitTimes.sudokuGameTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    SudokuPeaceModel peace = tappedPeace as SudokuPeaceModel;
    // if (!canSelectPeace.value) {
    //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    //   return;
    // }
    if (peace.isBaseNumber) {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
      return;
    }
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
    if (selectedNumber.value == peace.value || selectedNumber.value == 0) {
      sendCommand({"id": GameCommands.removePeace, "piece_id": peace.id});
      changePeaceValue(peace.id, 0);
      // addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    } else {
      sendCommand({
        "id": GameCommands.selectPeace,
        "piece_id": peace.id,
        "number": selectedNumber.value,
      });
      changePeaceValue(peace.id, selectedNumber.value);
      // addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
    }
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

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.sudoku;
    for (var i = 0; i < 81; i++) {
      peaces.add(
        Rx(
          SudokuPeaceModel(
            id: i,
            currentStatuses: [],
          ),
        ),
      );
    }
  }
}
