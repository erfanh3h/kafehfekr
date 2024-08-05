import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class OthelloPeaceModel extends PeaceModel {
  OthelloPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.isSuperPawn = false,
  });

  int? selectedUser;
  bool isSuperPawn;

  OthelloPeaceModel getFromJson(Map data, int id) {
    int? newSelectedUser;
    bool? newIsSuperPawn;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    newIsSuperPawn = data['is_super_pawn'];
    return OthelloPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  OthelloPeaceModel changeSelectedUser({
    int? newSelectedUser,
    bool? newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return OthelloPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  OthelloPeaceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return OthelloPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: newIsSuperPawn,
    );
  }

  OthelloPeaceModel resetPeace() {
    return OthelloPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      isSuperPawn: false,
    );
  }

  @override
  OthelloPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return OthelloPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }

  @override
  OthelloPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return OthelloPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }
}
