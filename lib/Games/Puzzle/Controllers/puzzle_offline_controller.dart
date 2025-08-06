import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class PuzzleOfflineController extends BaseOfflineGameController {
  int boardSize = 3;
  RxList<Rx<PeaceModel>> board = RxList([]);

  final moveCount = 0.obs;
  int currentEmptyIndex = 0;

  final List<List<int>> directions = [
    [0, -1],
    [-1, 0],
    [1, 0],
    [0, 1],
  ];

  int coordinateToIndex((int, int) position) {
    final index = position.$1 * boardSize + position.$2;
    return index;
  }

  (int, int) indexToCoordinate(int index) {
    final x = index % boardSize;
    final y = index ~/ boardSize;
    return (y, x);
  }

  onButtonTap(int index) {
    if (isGameFinished.value) {
      DialogComponent().showToast(label: AppTexts.gameFinished.tr);
      return;
    }
    if (currentEmptyIndex == index) {
      return;
    }
    final haveN = indexHaveEmptyNeighbour(index);
    if (haveN) {
      swapTwoPiece(index, currentEmptyIndex);
      currentEmptyIndex = index;
      moveCount.value += 1;
      isGameFinished.value = checkWinHappend();
      if (isGameFinished.value) {
        DialogComponent().showToast(label: AppTexts.youWinGame.tr);
      }
    }
  }

  bool indexHaveEmptyNeighbour(int index) {
    final coordinate = indexToCoordinate(index);
    for (var direction in directions) {
      final testX = direction[0] + coordinate.$1;
      final testY = direction[1] + coordinate.$2;
      if (testX < 0 || testY < 0) {
        continue;
      }
      if (testX >= boardSize || testY >= boardSize) {
        continue;
      }
      final testCoordinate = (testX, testY);
      final testIndex = coordinateToIndex(testCoordinate);
      if (board[testIndex].value.id == 0) {
        return true;
      }
    }
    return false;
  }

  swapTwoPiece(int source, int target) {
    int temp = board[source].value.id;
    board[source].value =
        board[source].value.copyWith(id: board[target].value.id);
    board[target].value = board[target].value.copyWith(id: temp);
    update();
  }

  bool checkWinHappend() {
    for (var i = 0; i < board.length; i++) {
      if (board[i].value.id == 0) {
        continue;
      }
      if (board[i].value.id != i + 1) {
        return false;
      }
    }
    return true;
  }

  _initializeBoard() {
    board.clear();
    board.value = List.generate(
      boardSize * boardSize,
      (id) => Rx(PeaceModel(id: id, currentStatuses: [])),
    );
    board.shuffle();
    board.shuffle();
    board.shuffle();
    for (var i = 0; i < board.length; i++) {
      if (board[i].value.id == 0) {
        currentEmptyIndex = i;
      }
    }
    update();
  }

  @override
  void resetGame() {
    moveCount.value = 0;
    isGameFinished.value = false;
    _initializeBoard();
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      boardSize = Get.arguments;
    }
    _initializeBoard();
    gameType = OfflineGameTypes.Puzzle;
  }
}
