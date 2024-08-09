import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class ChessPieceModel extends PeaceModel {
  ChessPieceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.isSuperPawn = false,
  });

  int? selectedUser;
  bool isSuperPawn;

  ChessPieceModel getFromJson(Map data, int id) {
    int? newSelectedUser;
    bool? newIsSuperPawn;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    newIsSuperPawn = data['is_super_pawn'];
    return ChessPieceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  ChessPieceModel changeSelectedUser({
    int? newSelectedUser,
    bool? newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return ChessPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  ChessPieceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return ChessPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: newIsSuperPawn,
    );
  }

  ChessPieceModel resetPeace() {
    return ChessPieceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      isSuperPawn: false,
    );
  }

  @override
  ChessPieceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return ChessPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }

  @override
  ChessPieceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return ChessPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }
}
