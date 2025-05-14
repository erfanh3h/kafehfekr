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

  LudoPieceModel addPiece(int newSelected, {int addCount = 1}) {
    final newCount = count + addCount;
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return LudoPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelected,
      count: newCount,
    );
  }

  LudoPieceModel reducePiece({int reduceCount = 1}) {
    final newCount = count - reduceCount;
    int newSelected = selectedUser ?? 0;
    List<PeaceStatusTypes> newStatuses = currentStatuses;
    if (newCount == 0) {
      newSelected = 0;
      newStatuses.clear();
    }
    return LudoPieceModel(
      id: id,
      currentStatuses: newStatuses,
      selectedUser: newSelected,
      count: newCount,
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
      count: count,
    );
  }

  @override
  LudoPieceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return LudoPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      count: count,
    );
  }
}
