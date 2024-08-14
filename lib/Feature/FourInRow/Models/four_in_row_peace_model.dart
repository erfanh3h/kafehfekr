import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class FourInRowPeaceModel extends PeaceModel {
  FourInRowPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
  });

  int? selectedUser;

  FourInRowPeaceModel getFromJson(Map data, int id) {
    int? newSelectedUser;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    return FourInRowPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  FourInRowPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return FourInRowPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  FourInRowPeaceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return FourInRowPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  FourInRowPeaceModel resetPeace() {
    return FourInRowPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
    );
  }

  @override
  FourInRowPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return FourInRowPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  FourInRowPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return FourInRowPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
