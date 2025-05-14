import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class LudoPieceModel extends PeaceModel {
  LudoPieceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
    this.count = 0,
  });

  int? selectedUser;
  int count;

  LudoPieceModel changeSelectedUser({
    int? newSelectedUser,
    int newCount = 1,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return LudoPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      count: newCount,
    );
  }

  LudoPieceModel resetPeace() {
    return LudoPieceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      count: 0,
    );
  }

  bool isEnemySpot(int gamerId) {
    return (selectedUser != null &&
        selectedUser != 0 &&
        selectedUser != gamerId);
  }

  @override
  LudoPieceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return LudoPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  LudoPieceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return LudoPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
