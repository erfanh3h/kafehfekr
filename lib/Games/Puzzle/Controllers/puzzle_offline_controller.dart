import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:refreshed/refreshed.dart';

class PuzzleOfflineController extends BaseOfflineGameController {
  int boardSize = 3;
  RxList<PeaceModel> board = RxList([]);

  final moveCount = 0.obs;

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
    board.value = List.generate(
      boardSize * boardSize,
      (id) => PeaceModel(id: id, currentStatuses: []),
    );
    board.shuffle();
    board.shuffle();
    board.shuffle();
  }

  @override
  void resetGame() {
    _initializeBoard();
  }

  @override
  void onInit() async {
    super.onInit();
    _initializeBoard();
    gameType = OfflineGameTypes.Puzzle;
  }
}
