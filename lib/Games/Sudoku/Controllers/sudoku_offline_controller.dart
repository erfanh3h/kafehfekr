import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Sudoku/Models/sudoku_peace_model.dart';
import 'package:refreshed/refreshed.dart';

class SudokuOfflineController extends BaseOfflineGameController {
  RxList<Rx<SudokuPeaceModel>> peaces = RxList();

  RxInt selectedNumber = RxInt(1);

  RxMap eachNumbersCount =
      RxMap({1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0});

  late int emptyCells;
  final base = 3;
  final size = 3 * 3;

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
    if (isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
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
    if (isGameFinished.value) {
      showInteraction(text: AppTexts.gameFinished.tr);
      return;
    }
    for (var piece in peaces.value) {
      if (piece.value.value == 0) {
        showInteraction(text: AppTexts.fillAllPieces.tr);
        return;
      }
    }
    if (isSolvedCorrectly()) {
      DialogComponent().showToast(label: AppTexts.youWinGame.tr);
      isGameFinished.value = true;
      return;
    } else {
      DialogComponent().showToast(label: AppTexts.wrongAnswer.tr);
    }
    // sendCommand({"id": GameCommands.solve});
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
    peaces.clear();
    final board = generateFullBoard();
    final maskedBoard = maskBoard(board);
    for (var i = 0; i < 81; i++) {
      final coordinate = indexToCoordinate(i);
      final value = maskedBoard[coordinate.$1][coordinate.$2];
      peaces.add(
        Rx(
          SudokuPeaceModel(
            id: i,
            currentStatuses: [],
            value: value,
            isBaseNumber: value != 0,
          ),
        ),
      );
    }
    showInteraction(sound: GameSoundTypes.startGame);
    getCountOfNumbers();
  }

  List<int> _range(int start, int stop) =>
      List.generate(stop - start, (i) => i + start);

  List<int> _shuffled(List<int> list) {
    final copy = List<int>.from(list);
    copy.shuffle();
    return copy;
  }

  List<List<int>> generateFullBoard() {
    final rBase = _range(0, base);

    final rows = [
      for (final g in _shuffled(rBase))
        for (final r in _shuffled(rBase)) g * base + r
    ];

    final cols = [
      for (final g in _shuffled(rBase))
        for (final c in _shuffled(rBase)) g * base + c
    ];

    final nums = _shuffled(_range(1, size + 1));

    List<List<int>> board = List.generate(size, (_) => List.filled(size, 0));

    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        int value = nums[(base * (r % base) + r ~/ base + c) % size];
        board[rows[r]][cols[c]] = value;
      }
    }

    return board;
  }

  List<List<int>> maskBoard(List<List<int>> board) {
    final puzzle = board.map((row) => List<int>.from(row)).toList();
    int removed = 0;

    while (removed < emptyCells) {
      int r = Random().nextInt(size);
      int c = Random().nextInt(size);
      if (puzzle[r][c] != 0) {
        puzzle[r][c] = 0;
        removed++;
      }
    }

    return puzzle;
  }

  bool isSolvedCorrectly() {
    final expected = Set.from(List.generate(size, (i) => i + 1));
    final List<List<int>> board = peacesToList();
    for (int i = 0; i < size; i++) {
      // بررسی سطر
      if (!setEquals(Set.from(board[i]), expected)) return false;
      // بررسی ستون
      final col = [for (int j = 0; j < size; j++) board[j][i]];
      if (!setEquals(Set.from(col), expected)) return false;
    }

    //بررسی بلوک‌های ۳×۳
    for (int row = 0; row < size; row += base) {
      for (int col = 0; col < size; col += base) {
        final block = <int>[];
        for (int r = 0; r < base; r++) {
          for (int c = 0; c < base; c++) {
            block.add(board[row + r][col + c]);
          }
        }
        if (!setEquals(Set.from(block), expected)) return false;
      }
    }

    return true;
  }

  List<List<int>> peacesToList() {
    List<List<int>> allBoard = [];
    for (int i = 0; i < size; i++) {
      List<int> rowData = [];
      for (int j = 0; j < size; j++) {
        final index = coordinateToIndex((i, j));
        rowData.add(peaces[index].value.value);
      }
      allBoard.add(rowData);
    }
    return allBoard;
  }

  (int, int) indexToCoordinate(int index) {
    final x = index % 9;
    final y = index ~/ 9;
    return (y, x);
  }

  int coordinateToIndex((int, int) position) {
    final index = position.$1 * 9 + position.$2;
    return index;
  }

  @override
  resetGame() {
    isGameFinished.value = false;
    initPieces();
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      emptyCells = Get.arguments;
    } else {
      emptyCells = 40;
    }
    super.onInit();
    gameType = OfflineGameTypes.Sudoku;
    initPieces();
  }
}
