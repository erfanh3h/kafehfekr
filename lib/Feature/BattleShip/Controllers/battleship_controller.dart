import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/battleship_game_piece_model.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/battleship_prepration_peace_model.dart';
import 'package:kafehfekr/Feature/BattleShip/Models/ship_model.dart';
import 'package:refreshed/refreshed.dart';

class BattleShipController extends BaseGameController {
  RxList<Rx<BattleShipPreprationPeaceModel>> pieces = RxList();

  List<Rx<ShipModel>> ships = [];

  RxInt selectedShip = RxInt(0);

  RxBool isGameInPlayPhase = RxBool(false);
  RxBool isWaiting = RxBool(false);
  RxList<Rx<BattleShipGamePieceModel>> player1Pieces = RxList();
  RxList<Rx<BattleShipGamePieceModel>> player2Pieces = RxList();

  @override
  void currentTurnFunction(Map data) {
    isGameInPlayPhase.value = true;
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      showInteraction(sound: GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.battleshipTurnTime);
  }

  @override
  void startGameFunction(Map data) {
    showInteraction(sound: GameSoundTypes.startGame);
    changetimerValue(GameWaitTimes.battleshipBoardTime);
  }

  @override
  void peaceSelectedFunction(Map data) {
    Map newData = data['data'];
    Map selectData = newData['select_data'];
    int index = selectData['index'];
    int gamerId = selectData['gamer_id'];
    int number = selectData['number'];
    bool isTurnWinHappened = selectData['is_turn_win_happened'];
    Get.find<TimerCompanent>().stopTimer();
    changePieceNumber(gamerId, index, number);
    checkIsShipCompleted(number, gamerId);
    if (isTurnWinHappened) {
      showInteraction(sound: GameSoundTypes.correct);
      if (gamerId == 1) {
        player1Score.value += 1;
      } else {
        player2Score.value += 1;
      }
      if (gamerId == myGameId) {
        canSelectPeace.value = true;
      }
      changetimerValue(GameWaitTimes.battleshipTurnTime);
    } else {
      showInteraction(sound: GameSoundTypes.tapWrong);
    }
  }

  @override
  void waitTimeFunction(Map data) {
    int time = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    changetimerValue(time);
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List player1BoardData = gameData['player1_board'];
    List player2BoardData = gameData['player2_board'];
    bool isPlayPhase = gameData['is_play_phase'];
    bool isPlayerRdy = gameData['is_player_rdy'];
    // bool isUserTurn = timerData['is_user_turn'];
    currentTurn.value = gameData['current_turn'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    isGameInPlayPhase.value = isPlayPhase;
    if (!isGameInPlayPhase.value) {
      isWaiting.value = isPlayerRdy;
      final int time =
          GameWaitTimes.battleshipBoardTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.battleshipBoardTime));
    } else {
      isWaiting.value = false;
      final int time =
          GameWaitTimes.battleshipTurnTime - timerData['time'] as int;
      changetimerValue(time.clamp(1, GameWaitTimes.battleshipTurnTime));
    }
    for (var i = 0; i < player1BoardData.length; i++) {
      player1Pieces[i].value =
          player1Pieces[i].value.getFromJson(player1BoardData[i], i);
    }
    for (var i = 0; i < player2BoardData.length; i++) {
      player2Pieces[i].value =
          player2Pieces[i].value.getFromJson(player2BoardData[i], i);
    }
    if (currentTurn.value == myGameId) {
      canSelectPeace.value = true;
    } else {
      canSelectPeace.value = false;
    }
    // if (isUserTurn) {
    //   final int time =
    //       GameWaitTimes.battleshipTurnTime - timerData['time'] as int;
    //   changetimerValue(time.clamp(1, GameWaitTimes.battleshipTurnTime));
    // }
  }

  @override
  Color returnTimerColor() {
    if (!isGameInPlayPhase.value) {
      return AppColors.darkColor;
    } else {
      if (currentTurn.value == 1) {
        return AppColors.imageRedColor;
      } else {
        return AppColors.imageBlueColor;
      }
    }
  }

  @override
  void onEachButtonTap(dynamic tappedPeace) {
    BattleShipGamePieceModel piece = tappedPeace as BattleShipGamePieceModel;
    if (!canSelectPeace.value) {
      showInteraction(text: AppTexts.notYourTurn.tr);
      return;
    }
    if (piece.isSelected) {
      showInteraction(text: AppTexts.selectedBefore.tr);
      return;
    }
    canSelectPeace.value = false;
    showInteraction(sound: GameSoundTypes.tap);
    sendCommand({
      "id": GameCommands.selectPeace,
      "data": piece.id,
    });
  }

  checkIsShipCompleted(int number, int gamerId) {
    if (gamerId == 1) {
      int count = 0;
      for (var piece in player2Pieces) {
        if (piece.value.isSelected && piece.value.number == number) {
          count++;
        }
      }
      if (count == number) {
        for (var i = 0; i < player2Pieces.length; i++) {
          if (player2Pieces[i].value.number == number) {
            changePieceIsShipCompleted(gamerId, i, true);
          }
        }
      }
    } else {
      int count = 0;
      for (var piece in player1Pieces) {
        if (piece.value.isSelected && piece.value.number == number) {
          count++;
        }
      }
      if (count == number) {
        for (var i = 0; i < player1Pieces.length; i++) {
          if (player1Pieces[i].value.number == number) {
            changePieceIsShipCompleted(gamerId, i, true);
          }
        }
      }
    }
  }

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
      showInteraction(text: AppTexts.selectedWrongPlace.tr);
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
    // sendCommand({"id": GameCommands.solve});
  }

  submitBoard() {
    Map<String, List<int>> data = {};
    for (var ship in ships) {
      if (!ship.value.isLocationSet) {
        showInteraction(text: AppTexts.selectAllShips.tr);
        return;
      } else {
        data[ship.value.length.toString()] = ship.value.positions;
      }
    }
    sendCommand({"id": GameCommands.saveBoard, "data": data});
    isWaiting.value = true;
  }

  void changePieceNumber(int gamerId, int index, int number) {
    if (gamerId == 2) {
      player1Pieces[index].value =
          player1Pieces[index].value.changeNumber(number: number);
    } else {
      player2Pieces[index].value =
          player2Pieces[index].value.changeNumber(number: number);
    }
  }

  void changePieceIsShipCompleted(int gamerId, int index, bool status) {
    if (gamerId == 2) {
      player1Pieces[index].value = player1Pieces[index]
          .value
          .changeIsShipCompleted(isShipCompleted: status);
    } else {
      player2Pieces[index].value = player2Pieces[index]
          .value
          .changeIsShipCompleted(isShipCompleted: status);
    }
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
      player1Pieces
          .add(Rx(BattleShipGamePieceModel(id: i, currentStatuses: [])));
      player2Pieces
          .add(Rx(BattleShipGamePieceModel(id: i, currentStatuses: [])));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.BattleShip;
    initPieces();
  }
}
