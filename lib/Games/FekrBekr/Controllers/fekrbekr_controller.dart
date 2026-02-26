import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/FekrBekr/Models/fekrbekr_piece_model.dart';
import 'package:refreshed/refreshed.dart';

class FekrBekrController extends BaseGameController {
  RxList<Rx<FekrBekrPeaceModel>> peaces = RxList();

  RxBool isGameInPlayPhase = RxBool(false);
  RxBool isWaiting = RxBool(false);

  RxList<List<int>> player1Choices = RxList([]);
  RxList<List<int>> player2Choices = RxList([]);

  RxList<List<int>> player1Results = RxList([]);
  RxList<List<int>> player2Results = RxList([]);

  RxList<int> currentResult = RxList([0, 0, 0, 0]);

  RxInt selectedPeaceIndex = RxInt(-1);
  RxInt selectedNumber = RxInt(-1);

  List<int> myBoard = [0, 0, 0, 0];
  bool isMyboardSet = false;

  final ScrollController historyController = ScrollController();
  @override
  void currentTurnFunction(Map data) {
    isGameInPlayPhase.value = true;
    isWaiting.value = false;
    selectedPeaceIndex.value = -1;
    selectedNumber.value = -1;
    resetPieces();
    int turn = data['data']['current_round'];
    currentRound.value = turn;
    if (currentRound.value == 1 && !isMyboardSet) {
      myBoard = [1, 2, 3, 4];
      //if user didnt set his board this will auto set in round 1
    }
    canSelectPeace.value = true;
    showInteraction(sound: GameSoundTypes.startTurn);
    changetimerValue(GameWaitTimes.fekrBekrTurnTime);
  }

  @override
  void startGameFunction(Map data) {
    showInteraction(sound: GameSoundTypes.startGame);
    changetimerValue(GameWaitTimes.fekrBekrBoardTime);
    canSelectPeace.value = true;
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map newData = data['data'];
    List<int> selectionData = List<int>.from(newData['data']);
    List<int> result = List<int>.from(newData['result']);
    int gamerId = newData['gamer_id'];
    if (gamerId == 1) {
      player1Choices.value.add(selectionData);
      player1Results.value.add(result);
    } else {
      player2Choices.value.add(selectionData);
      player2Results.value.add(result);
    }
    if (gamerId == myGameId) {
      currentResult.value = result;
    }
    update();
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => historyController.jumpTo(0));
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    myBoard = List<int>.from(gameData['board']);
    for (var data in gameData['player1_choices']) {
      player1Choices.value.add(List<int>.from(data));
    }
    for (var data in gameData['player2_choices']) {
      player2Choices.value.add(List<int>.from(data));
    }
    for (var data in gameData['player1_results']) {
      player1Results.value.add(List<int>.from(data));
    }
    for (var data in gameData['player2_results']) {
      player2Results.value.add(List<int>.from(data));
    }
    Future.delayed(const Duration(milliseconds: 500)).then((_) =>
        historyController.jumpTo(historyController.position.maxScrollExtent));
    isGameInPlayPhase.value = gameData['is_play_phase'];
    currentRound.value = gameData['current_round'];
    if (!isGameInPlayPhase.value) {
      isWaiting.value = gameData['is_player_rdy'];
    } else {
      isWaiting.value = gameData['is_turn_played'];
    }
    if (!isWaiting.value) {
      canSelectPeace.value = true;
    }
    update();
    if (!isGameInPlayPhase.value) {
      final int time =
          GameWaitTimes.fekrBekrTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    } else {
      final int time =
          GameWaitTimes.fekrBekrBoardTime - timerData['time'] as int;
      changetimerValue(time.clamp(0, time));
    }
  }

  @override
  Color? returnTimerColor() {
    return null;
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    FekrBekrPeaceModel piece = tappedPeace as FekrBekrPeaceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
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

  (bool, int?) checkChoicesContainsNumber(int number) {
    for (var i = 0; i < peaces.length; i++) {
      if (number == peaces[i].value.value) {
        return (true, i);
      }
    }
    return (false, null);
  }

  void changeSelectedNumber(int index) {
    if (index == selectedNumber.value) {
      selectedNumber.value = -1;
    } else {
      selectedNumber.value = index;
    }
  }

  void sendResult(String command) {
    for (var peace in peaces) {
      if (peace.value.value == 0) {
        showInteraction(sound: GameSoundTypes.tapWrong);
        return;
      }
      if (peaces
              .where((word) => word.value.value == peace.value.value)
              .length !=
          1) {
        // check dont repeated number
        showInteraction(sound: GameSoundTypes.tapWrong);
        return;
      }
    }

    canSelectPeace.value = false;
    List<int> result = [];
    for (var peace in peaces) {
      result.add(peace.value.value);
    }
    if (command == GameCommands.saveBoard) {
      myBoard = result;
      isMyboardSet = true;
    }
    sendCommand({"id": command, "data": result});
    isWaiting.value = true;
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
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.FekrBekr;
    initPieces();
  }
}
