import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class MNumbersPeaceModel extends PeaceModel {
  MNumbersPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.value,
  });

  int? selectedUser;
  int? value;

  MNumbersPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    late PeaceModel data;
    if (newSelectedUser != null) {
      data = super.addStatus(status: PeaceStatusTypes.selected);
    } else {
      data = super.removeStatus(status: PeaceStatusTypes.selected);
    }

    return MNumbersPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      value: value,
    );
  }

  MNumbersPeaceModel changeValue({
    int? newValue,
  }) {
    return MNumbersPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      value: newValue,
      selectedUser: selectedUser,
    );
  }

  MNumbersPeaceModel resetPeace() {
    return MNumbersPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      value: null,
    );
  }

  @override
  MNumbersPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return MNumbersPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }

  @override
  MNumbersPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return MNumbersPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }
}
