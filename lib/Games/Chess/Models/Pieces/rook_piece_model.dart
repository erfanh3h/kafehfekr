import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Games/Chess/Models/chess_piece_model.dart';

class RookPieceModel extends ChessPieceModel {
  RookPieceModel({
    super.gamerId,
    super.isMultiMove,
    super.isFirstMove,
    super.image,
  });
  @override
  String get image => GeneralIcons.rook;

  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [(1, 0), (-1, 0), (0, 1), (0, -1)];
    return result;
  }

  @override
  ChessPieceModel copyWith({
    int? gamerId,
    bool? isFirstMove,
  }) =>
      RookPieceModel(
        gamerId: gamerId ?? this.gamerId,
        isMultiMove: isMultiMove,
        isFirstMove: isFirstMove ?? this.isFirstMove,
        image: image,
      );
}
