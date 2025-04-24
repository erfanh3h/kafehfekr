import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class PentagoPeaceModel extends PeaceModel {
  PentagoPeaceModel({
    required super.id,
    required super.currentStatuses,
    required this.selectedUser,
  });

  int selectedUser;

  PentagoPeaceModel getFromJson(Map data, int id) {
    int newSelectedUser = 0;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    return PentagoPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  PentagoPeaceModel changeSelectedUser({
    required int newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return PentagoPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  PentagoPeaceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return PentagoPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  PentagoPeaceModel resetPeace() {
    return PentagoPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: 0,
    );
  }

  @override
  PentagoPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return PentagoPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  PentagoPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return PentagoPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
