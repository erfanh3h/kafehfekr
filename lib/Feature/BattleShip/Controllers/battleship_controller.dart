import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/battleship_prepration_peace_model.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipController extends BaseGameController {
  RxList<RxInt> numberValues = RxList();

  RxList<Rx<BattleShipPreprationPeaceModel>> pieces = RxList();

  int maxRound = GameRoundCounts.tenRoundCount;

  RxBool letSendResult = RxBool(false);
  RxDouble result = RxDouble(0);

  List<int> currentNumbers = [];

  List<Rx<ShipModel>> ships = [];

  @override
  void currentTurnFunction(Map data) {
    List<int> listNumbers = List<int>.from(data['data']);
    currentNumbers = listNumbers;
    Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    changetimerValue(GameWaitTimes.tenRoundTime);
  }

  @override
  void newRoundFunction(Map data) {
    int newRound = data['data'];
    currentRound.value = newRound;
    resetValues();
  }

  @override
  void finishRoundFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    int roundWinner = newData['Winner'] ?? 0;
    if (roundWinner == 1) {
      player1Score.value += 1;
    } else if (roundWinner == 2) {
      player2Score.value += 1;
    }
    FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
    changetimerValue(GameWaitTimes.tenSleepRoundTime);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List<int> listNumbers = List<int>.from(gameData['current_numbers']);
    currentNumbers = listNumbers;
    currentRound.value = gameData['current_round'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    final int time = GameWaitTimes.tenRoundTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  bool checkRepeatedNumberCanEnter(int number) {
    int repeatCount = 0;
    for (var num in currentNumbers) {
      if (num == number) {
        repeatCount += 1;
      }
    }
    int numbersRepeatCount = 0;

    for (var num in numberValues) {
      if (num.value == number) {
        numbersRepeatCount += 1;
      }
    }
    if (numbersRepeatCount < repeatCount) {
      return true;
    }
    return false;
  }

  bool checkNumbersHaveValue(int value) {
    bool result = false;
    for (var dataRaw in numberValues) {
      if (dataRaw.value == value) {
        if (!checkRepeatedNumberCanEnter(value)) {
          result = true;
          break;
        }
      }
    }
    return result;
  }

  onShipRemove(int index) {
    numberValues[index].value = -1;
  }

  onPositionAccept(int index, ShipModel ship) {
    print(index);
  }

  int getShipIdOfPiece(int pieceId) {
    for (var ship in ships) {
      if (ship.value.positions.contains(pieceId)) {
        return ship.value.id;
      }
    }
    return 0;
  }

  sendResult() {
    if (!letSendResult.value) {
      return;
    }
    // sendCommand({"id": GameCommands.solve});
  }

  void resetValues() {
    // for (var i = 0; i < operatorValues.length; i++) {
    //   operatorValues[i].value = "";
    // }
    // for (var i = 0; i < numberValues.length; i++) {
    //   numberValues[i].value = -1;
    // }
    // result.value = 0;
  }

  initPieces() {
    ships.add(Rx(ShipModel(id: 1, length: 5, positions: [0, 8, 16, 24, 32])));
    ships.add(Rx(ShipModel(id: 2, length: 4, positions: [1, 9, 17, 25])));
    ships.add(Rx(ShipModel(id: 3, length: 3, positions: [2, 10, 18])));
    ships.add(Rx(ShipModel(id: 4, length: 2, positions: [3, 11])));
    for (var i = 0; i < 64; i++) {
      pieces
          .add(Rx(BattleShipPreprationPeaceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.battleship;
    initPieces();
  }
}
