import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BoxFourPeaceModel extends PeaceModel {
  BoxFourPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser = 0,
    this.value = 0,
  });

  int selectedUser;
  int value;

  BoxFourPeaceModel getFromJson(Map data, int id) {
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      selectedUser: data['equipped_user'],
      value: data['value'],
    );
  }

  BoxFourPeaceModel changeValue({
    int? newValue,
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      value: newValue ?? value,
      selectedUser: newSelectedUser ?? selectedUser,
    );
  }

  BoxFourPeaceModel resetPeace() {
    return BoxFourPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: 0,
      value: 0,
    );
  }

  @override
  BoxFourPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BoxFourPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }

  @override
  BoxFourPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BoxFourPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      value: value,
    );
  }
}
