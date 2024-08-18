import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BoxFourPeaceModel extends PeaceModel {
  BoxFourPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
  });

  int? selectedUser;

  BoxFourPeaceModel getFromJson(Map data, int id) {
    int? newSelectedUser;
    if (data['pawn_gamer_id'] != null) {
      newSelectedUser = data['pawn_gamer_id'];
    }
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  BoxFourPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  BoxFourPeaceModel changeIsSuperPawn({
    required bool newIsSuperPawn,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  BoxFourPeaceModel resetPeace() {
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
    );
  }

  @override
  BoxFourPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BoxFourPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  BoxFourPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BoxFourPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
