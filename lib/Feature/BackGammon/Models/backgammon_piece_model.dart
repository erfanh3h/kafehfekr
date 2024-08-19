import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BackGammonPeaceModel extends PeaceModel {
  BackGammonPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser = 0,
    this.count = 0,
  });

  int selectedUser;
  int count;

  BackGammonPeaceModel getFromJson(Map data, int id) {
    return BackGammonPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      count: data['count'],
      selectedUser: data['equipped_user'],
    );
  }

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
      selectedUser: newSelectedUser ?? selectedUser,
      count: count,
    );
  }

  BackGammonPeaceModel changecount({
    int? newcount,
    int? newSelectedUser,
  }) {
    return BackGammonPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      count: newcount ?? count,
      selectedUser: newSelectedUser ?? selectedUser,
    );
  }

  BackGammonPeaceModel resetPeace() {
    return BackGammonPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: 0,
      count: 0,
    );
  }

  @override
  BackGammonPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BackGammonPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      count: count,
    );
  }

  @override
  BackGammonPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BackGammonPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      count: count,
    );
  }
}
