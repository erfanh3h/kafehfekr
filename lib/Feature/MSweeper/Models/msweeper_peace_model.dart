import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class MSweeperPeaceModel extends PeaceModel {
  MSweeperPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
  });

  int? selectedUser;

  MSweeperPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  MSweeperPeaceModel resetPeace() {
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
    );
  }

  @override
  MSweeperPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  MSweeperPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
