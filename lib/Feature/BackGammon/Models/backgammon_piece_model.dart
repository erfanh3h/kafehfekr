import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BackGammonPeaceModel extends PeaceModel {
  BackGammonPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.value,
  });

  int? selectedUser;
  int? value;

  BackGammonPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    late PeaceModel data;
    if (newSelectedUser != null) {
      data = super.addStatus(status: PeaceStatusTypes.selected);
    } else {
      data = super.removeStatus(status: PeaceStatusTypes.selected);
    }

    return BackGammonPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      value: value,
    );
  }

  BackGammonPeaceModel changeValue({
    int? newValue,
  }) {
    return BackGammonPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      value: newValue,
      selectedUser: selectedUser,
    );
  }

  BackGammonPeaceModel resetPeace() {
    return BackGammonPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      value: null,
    );
  }

  @override
  BackGammonPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BackGammonPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }

  @override
  BackGammonPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BackGammonPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }
}
