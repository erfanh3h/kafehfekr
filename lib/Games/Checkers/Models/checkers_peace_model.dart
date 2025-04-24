import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class CheckersPeaceModel extends PeaceModel {
  CheckersPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.isSuperPawn = false,
  });

  int? selectedUser;
  bool isSuperPawn;

  CheckersPeaceModel getFromJson(Map data, int id) {
    int? newSelectedUser;
    bool? newIsSuperPawn;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    newIsSuperPawn = data['is_super_pawn'];
    return CheckersPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  CheckersPeaceModel changeSelectedUser({
    int? newSelectedUser,
    bool? newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return CheckersPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      isSuperPawn: newIsSuperPawn ?? false,
    );
  }

  CheckersPeaceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return CheckersPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: newIsSuperPawn,
    );
  }

  CheckersPeaceModel resetPeace() {
    return CheckersPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      isSuperPawn: false,
    );
  }

  @override
  CheckersPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return CheckersPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }

  @override
  CheckersPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return CheckersPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      isSuperPawn: isSuperPawn,
    );
  }
}
