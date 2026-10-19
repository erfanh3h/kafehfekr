import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Games/Chess/Models/chess_piece_model.dart';

class BishopPieceModel extends ChessPieceModel {
  BishopPieceModel({
    super.gamerId,
    super.isMultiMove,
    super.isFirstMove,
    super.image,
  });
  @override
  String get image => GeneralIcons.bishop;

  @override
  List<(int, int)> getMovesList() {
    List<(int, int)> result = [(-1, 1), (1, 1), (1, -1), (-1, -1)];
    return result;
  }

  @override
  ChessPieceModel copyWith({
    int? gamerId,
    bool? isFirstMove,
  }) =>
      BishopPieceModel(
        gamerId: gamerId??this.gamerId,
        isMultiMove: isMultiMove,
        isFirstMove: isFirstMove ?? this.isFirstMove,
        image: image,
      );
}
