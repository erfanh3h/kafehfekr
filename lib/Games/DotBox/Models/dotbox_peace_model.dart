import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class DotBoxPeaceModel extends PeaceModel {
  DotBoxPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
  });

  int? selectedUser;

  DotBoxPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return DotBoxPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  DotBoxPeaceModel resetPeace() {
    return DotBoxPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
    );
  }

  @override
  DotBoxPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return DotBoxPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  DotBoxPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return DotBoxPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
