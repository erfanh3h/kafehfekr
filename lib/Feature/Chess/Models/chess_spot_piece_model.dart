import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/bishop_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/king_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/knight_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/pawn_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/queen_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/Pieces/rook_piece_model.dart';
import 'package:kafehfekr/Feature/Chess/Models/chess_piece_model.dart';

class ChessSpotModel extends PeaceModel {
  ChessSpotModel({
    required super.id,
    required super.currentStatuses,
    required this.piece,
  });

  ChessPieceModel piece;

  ChessSpotModel getFromJson(Map data, int id) {
    late ChessPieceModel newPiece;
    int gamerId = data['gamer_id'];
    bool isFirstMove = data['is_first_move'];
    String pieceName = data['name'];
    switch (pieceName) {
      case "Pawn":
        newPiece = PawnPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      case "Rook":
        newPiece = RookPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      case "Knight":
        newPiece = KnightPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      case "Bishop":
        newPiece = BishopPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      case "Queen":
        newPiece = QueenPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      case "King":
        newPiece = KingPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
      default:
        newPiece = PawnPieceModel(gamerId: gamerId, isFirstMove: isFirstMove);
        break;
    }
    return ChessSpotModel(
      id: id,
      currentStatuses: currentStatuses,
      piece: newPiece,
    );
  }

  ChessSpotModel changePiece({
    required ChessPieceModel newPiece,
  }) {
    return ChessSpotModel(
      id: id,
      currentStatuses: currentStatuses,
      piece: newPiece,
    );
  }

  ChessSpotModel resetPeace() {
    return ChessSpotModel(
      id: id,
      currentStatuses: [],
      piece: ChessPieceModel(),
    );
  }

  @override
  ChessSpotModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return ChessSpotModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      piece: piece,
    );
  }

  @override
  ChessSpotModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return ChessSpotModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      piece: piece,
    );
  }
}
