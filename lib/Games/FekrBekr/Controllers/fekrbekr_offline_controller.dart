import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/FekrBekr/Models/fekrbekr_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrOfflineController extends BaseOfflineGameController {
  RxList<Rx<FekrBekrPeaceModel>> peaces = RxList();

  RxList<List<int>> playerChoices = RxList([]);
  RxList<List<int>> playerResults = RxList([]);

  RxInt selectedPeaceIndex = RxInt(-1);
  RxInt selectedNumber = RxInt(-1);

  List<int> baseBoard = [];

  bool checkBoardContainsNumber(int number) {
    for (var i = 0; i < baseBoard.length; i++) {
      if (baseBoard[i] == number) {
        return true;
      }
    }
    return false;
  }

  (bool, int?) checkChoicesContainsNumber(int number) {
    for (var i = 0; i < peaces.length; i++) {
      if (number == peaces[i].value.value) {
        return (true, i);
      }
    }
    return (false, null);
  }

  void submitChoice() {
    final List<int> selectionData = [
      peaces[0].value.value,
      peaces[1].value.value,
      peaces[2].value.value,
      peaces[3].value.value,
    ];
    if (selectionData.contains(0)) {
      showInteraction(text: AppTexts.fillAllPieces.tr);
      return;
    }
    List<int> result = [];
    for (var i = 0; i < selectionData.length; i++) {
      if (selectionData[i] == baseBoard[i]) {
        result.add(2);
        continue;
      }
      bool checkBoardResult = checkBoardContainsNumber(selectionData[i]);
      if (checkBoardResult) {
        result.add(1);
        continue;
      }
      result.add(0);
    }
    result.shuffle();
    playerChoices.value.add(selectionData);
    playerResults.value.add(result);
    update();
    if (listEquals(result, [2, 2, 2, 2])) {
      DialogComponent().showToast(label: AppTexts.youWinGame.tr);
      isGameFinished.value = true;
    } else {}
    selectedNumber.value = -1;
    resetPieces();
  }

  void onEachButtonTap(dynamic tappedPeace) {
    FekrBekrPeaceModel piece = tappedPeace as FekrBekrPeaceModel;
    if (isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    showInteraction(sound: GameSoundTypes.tap);
    if (selectedNumber.value == -1) {
      peaces.value[piece.id].value =
          peaces.value[piece.id].value.changeValue(newValue: 0);
    } else {
      if (selectedNumber.value == peaces.value[piece.id].value.value) {
        peaces.value[piece.id].value =
            peaces.value[piece.id].value.changeValue(newValue: 0);
      } else {
        final checkRepeat = checkChoicesContainsNumber(selectedNumber.value);
        if (checkRepeat.$1) {
          peaces.value[checkRepeat.$2!].value =
              peaces.value[checkRepeat.$2!].value.changeValue(newValue: 0);
        }
        peaces.value[piece.id].value = peaces.value[piece.id].value
            .changeValue(newValue: selectedNumber.value);
      }
    }
  }

  void changeSelectedNumber(int index) {
    if (index == selectedNumber.value) {
      selectedNumber.value = -1;
    } else {
      selectedNumber.value = index;
    }
  }

  void resetPieces() {
    for (var i = 0; i < 4; i++) {
      peaces.value[i].value = peaces.value[i].value.changeValue(newValue: 0);
    }
  }

  void initPieces() {
    for (var i = 0; i < 4; i++) {
      peaces.add(Rx(FekrBekrPeaceModel(id: i, currentStatuses: [], value: 0)));
    }
    for (var i = 0; i < 4; i++) {
      final int randomNumber = Random().nextInt(8) + 1;
      if (!baseBoard.contains(randomNumber)) {
        baseBoard.add(randomNumber);
      } else {
        i--;
      }
    }
  }

  @override
  resetGame() {
    peaces.clear();
    playerChoices.clear();
    playerResults.clear();
    selectedPeaceIndex.value = -1;
    selectedNumber.value = -1;
    baseBoard.clear();
    isGameFinished.value = false;
    initPieces();
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = OfflineGameTypes.FekrBekr;
    initPieces();
  }
}
