import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class KnightPieceModel extends ChessPieceModel {
  KnightPieceModel({
    super.gamerId,
    super.isMultiMove,
    super.isFirstMove,
    super.image,
  });
  @override
  String get image => GeneralIcons.knight;
  
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
