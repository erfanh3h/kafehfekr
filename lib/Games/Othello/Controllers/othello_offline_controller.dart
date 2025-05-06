import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

enum Disk { none, black, white }

class OthelloOfflineController extends BaseOfflineGameController {
  static const int boardSize = 8;
  final board = List.generate(
      boardSize, (_) => List.generate(boardSize, (_) => Disk.none)).obs;
  final currentPlayer = Disk.black.obs;
  final startingPlayer = Disk.black.obs;
  final possibleMoves = <List<int>>[].obs;
  final blackCount = 0.obs;
  final whiteCount = 0.obs;
  final isGameOver = false.obs;
  final winnerLabel = ''.obs;

  final List<List<int>> directions = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1],
  ];

  void _initializeBoard() {
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        board[i][j] = Disk.none;
      }
    }
    board[3][3] = Disk.white;
    board[3][4] = Disk.black;
    board[4][3] = Disk.black;
    board[4][4] = Disk.white;
  }

  @override
  void resetGame() {
    isGameOver.value = false;
    winnerLabel.value = '';
    currentPlayer.value = startingPlayer.value;
    _initializeBoard();
    _calculatePossibleMoves();
    _updateCounts();
  }

  bool _isInBounds(int x, int y) =>
      x >= 0 && x < boardSize && y >= 0 && y < boardSize;

  bool _canFlip(int x, int y, int dx, int dy) {
    int i = x + dx;
    int j = y + dy;
    bool hasOpponentDisk = false;

    while (_isInBounds(i, j) &&
        board[i][j] != Disk.none &&
        board[i][j] != currentPlayer.value) {
      hasOpponentDisk = true;
      i += dx;
      j += dy;
    }

    if (!hasOpponentDisk ||
        !_isInBounds(i, j) ||
        board[i][j] != currentPlayer.value) {
      return false;
    }
    return true;
  }

  void _calculatePossibleMoves() {
    possibleMoves.clear();
    for (int x = 0; x < boardSize; x++) {
      for (int y = 0; y < boardSize; y++) {
        if (board[x][y] != Disk.none) continue;
        for (var dir in directions) {
          if (_canFlip(x, y, dir[0], dir[1])) {
            possibleMoves.add([x, y]);
            break;
          }
        }
      }
    }
  }

  void _updateCounts() {
    int black = 0;
    int white = 0;
    for (var row in board) {
      for (var cell in row) {
        if (cell == Disk.black) black++;
        if (cell == Disk.white) white++;
      }
    }
    blackCount.value = black;
    whiteCount.value = white;
  }

  void _determineWinner() {
    if (blackCount.value > whiteCount.value) {
      winnerLabel.value = 'سیاه برنده شد';
    } else if (whiteCount.value > blackCount.value) {
      winnerLabel.value = 'سفید برنده شد';
    } else {
      winnerLabel.value = 'بازی مساوی شد';
    }
  }

  void placeDisk(int x, int y) {
    if (board[x][y] != Disk.none || !_isValidMove(x, y)) return;

    board[x][y] = currentPlayer.value;
    for (var dir in directions) {
      int i = x + dir[0];
      int j = y + dir[1];
      List<List<int>> toFlip = [];

      while (_isInBounds(i, j) &&
          board[i][j] != Disk.none &&
          board[i][j] != currentPlayer.value) {
        toFlip.add([i, j]);
        i += dir[0];
        j += dir[1];
      }

      if (_isInBounds(i, j) && board[i][j] == currentPlayer.value) {
        for (var pos in toFlip) {
          board[pos[0]][pos[1]] = currentPlayer.value;
        }
      }
    }

    _updateCounts();

    Disk nextPlayer =
        currentPlayer.value == Disk.black ? Disk.white : Disk.black;
    currentPlayer.value = nextPlayer;
    _calculatePossibleMoves();

    if (possibleMoves.isEmpty) {
      currentPlayer.value =
          currentPlayer.value == Disk.black ? Disk.white : Disk.black;
      _calculatePossibleMoves();

      if (possibleMoves.isEmpty) {
        isGameOver.value = true;
        _determineWinner();
        DialogComponent().showToast(label: winnerLabel.value);
      } else {
        DialogComponent().showToast(
            label: 'بازیکن حریف امکان حرکت ندارد. نوبت شما باقی می‌ماند.');
      }
    }
  }

  bool _isValidMove(int x, int y) {
    return possibleMoves.any((pos) => pos[0] == x && pos[1] == y);
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Othello;
    startingPlayer.value = Disk.white;
    resetGame();
  }
}
