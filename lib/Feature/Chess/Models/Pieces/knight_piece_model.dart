import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class KnightPieceModel extends ChessPieceModel {
  @override
  bool get isMultiMove => false;

  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [
      (-2, 1),
      (-1, 2),
      (1, 2),
      (2, 1),
      (2, -1),
      (1, -2),
      (-1, -2),
      (-2, -1)
    ];
    return result;
  }
}
