import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class BishopPieceModel extends ChessPieceModel {
  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [(-1, 1), (1, 1), (1, -1), (-1, -1)];
    return result;
  }
}
