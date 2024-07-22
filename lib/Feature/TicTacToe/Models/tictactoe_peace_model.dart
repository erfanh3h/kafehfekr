import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/status_types.dart';

class TicTacToePeaceModel extends PeaceModel {
  TicTacToePeaceModel({
    required super.id,
    required super.currentStatuses,
    this.selectedUser,
  });

  int? selectedUser;

  TicTacToePeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return TicTacToePeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
    );
  }

  TicTacToePeaceModel resetPeace() {
    return TicTacToePeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
    );
  }

  @override
  TicTacToePeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return TicTacToePeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }

  @override
  TicTacToePeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return TicTacToePeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
    );
  }
}
