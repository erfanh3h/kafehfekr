import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
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
    if (data['pawn_gamer_id'] != null) {
      newPiece = data['pawn_gamer_id'];
    } else {
      newPiece = ChessPieceModel();
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
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return ChessSpotModel(
      id: id,
      currentStatuses: data.currentStatuses,
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
