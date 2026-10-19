import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Games/Chess/Models/chess_piece_model.dart';

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
  bool get isMultiMove => false;
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
    if (isFirstMove) {
      result.add((0, 2));
      result.add((0, -2));
    }
    return result;
  }

  @override
  ChessPieceModel copyWith({
    int? gamerId,
    bool? isFirstMove,
  }) =>
      KingPieceModel(
        gamerId: gamerId ?? this.gamerId,
        isMultiMove: isMultiMove,
        isFirstMove: isFirstMove ?? this.isFirstMove,
        image: image,
      );
}
