import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class KingPieceModel extends ChessPieceModel {
  KingPieceModel({
    super.gamerId,
    super.isMultiMove,
    super.isFirstMove,
    super.image,
  });
  @override
  String get image => GeneralIcons.king;
  
  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [
      (1, 0),
      (-1, 0),
      (0, 1),
      (0, -1),
      (-1, 1),
      (1, 1),
      (1, -1),
      (-1, -1)
    ];
    return result;
  }
}
