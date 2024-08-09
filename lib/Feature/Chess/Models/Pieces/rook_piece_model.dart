import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class RookPieceModel extends ChessPieceModel {
  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [(1, 0), (-1, 0), (0, 1), (0, -1)];
    return result;
  }
}
