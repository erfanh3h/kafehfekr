import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Games/Chess/Models/chess_piece_model.dart';

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

  @override
  ChessPieceModel copyWith({
    int? gamerId,
    bool? isFirstMove,
  }) =>
      KnightPieceModel(
        gamerId: gamerId??this.gamerId,
        isMultiMove: isMultiMove,
        isFirstMove: isFirstMove ?? this.isFirstMove,
        image: image,
      );
}
