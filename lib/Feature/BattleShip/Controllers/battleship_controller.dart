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

  RxInt selectedShip = RxInt(0);

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

  // onShipRemove(int index) {
  //   numberValues[index].value = -1;
  // }

  List<int> getNewPositions(int newIndex, ShipModel pieceData) {
    List<int> newPositions = [];
    (int, int) newPosition = indexToCoordinate(newIndex);
    for (var i = 0; i < pieceData.length; i++) {
      int col = newPosition.$1 + (pieceData.direction.$1 * i);
      int row = newPosition.$2 + (pieceData.direction.$2 * i);
      if (!isValidPosition(col, row)) {
        return [];
      }
      newPositions.add(coordinateToIndex((col, row)));
    }
    return newPositions;
  }

  checkPositionsAreEmpty(List<int> newPositions) {
    List<int> positions = [];
    for (var ship in ships) {
      positions.addAll(ship.value.positions);
    }
    for (var position in newPositions) {
      if (positions.contains(position)) {
        return false;
      }
    }
    return true;
  }

  onPositionAccept(int index) {
    List<int> newPositions =
        getNewPositions(index, ships[selectedShip.value].value);
    if (newPositions.isNotEmpty && checkPositionsAreEmpty(newPositions)) {
      ships[selectedShip.value].value =
          ships[selectedShip.value].value.changePositions(newPositions);
      ships[selectedShip.value].value =
          ships[selectedShip.value].value.changeIsLocationSet(true);
    } else {
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
    }
  }

  onRemoveShip(ShipModel ship) {
    ships[ship.id].value = ships[ship.id].value.changeIsLocationSet(false);
    ships[ship.id].value = ships[ship.id].value.changePositions([]);
  }

  int getShipIdOfPiece(int pieceId) {
    for (var ship in ships) {
      if (ship.value.positions.contains(pieceId)) {
        return ship.value.id;
      }
    }
    return 0;
  }

  void onTapSelectionShip(ShipModel ship) {
    selectedShip.value = ship.id;
  }

  void onRotateShip(ShipModel ship) {
    onRemoveShip(ship);
    ships[ship.id].value = ships[ship.id].value.rotate();
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
    // ships.add(Rx(ShipModel(id: 0, length: 5, positions: [0, 8, 16, 24, 32])));
    // ships.add(Rx(ShipModel(id: 1, length: 4, positions: [1, 9, 17, 25])));
    // ships.add(Rx(ShipModel(id: 2, length: 3, positions: [2, 10, 18])));
    // ships.add(Rx(ShipModel(id: 3, length: 2, positions: [3, 11])));
    for (var i = 0; i < 4; i++) {
      ships.add(Rx(ShipModel(id: i, length: i + 2, positions: [])));
    }
    for (var i = 0; i < 64; i++) {
      pieces.add(Rx(BattleShipPreprationPeaceModel(
        id: i,
        currentStatuses: [],
        shipId: -1,
      )));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.battleship;
    initPieces();
  }
}
