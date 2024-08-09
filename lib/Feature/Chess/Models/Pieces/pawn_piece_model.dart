import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class PawnPieceModel extends ChessPieceModel {
  PawnPieceModel({
    super.gamerId,
    super.isMultiMove,
    super.isFirstMove,
    super.image,
  });
  @override
  String get image => GeneralIcons.pawn;

  @override
  bool get isMultiMove => false;

  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [];
    if (gamerId == 1) {
      result.add((1, 0));
    } else {
      result.add((-1, 0));
    }
    return result;
  }

  @override
  List<(int, int)> getHitsList() {
    List<(int, int)> result = [];
    if (gamerId == 1) {
      result = [(1, -1), (1, 1)];
    } else {
      result = [(-1, -1), (-1, 1)];
    }
    return result;
  }
}
