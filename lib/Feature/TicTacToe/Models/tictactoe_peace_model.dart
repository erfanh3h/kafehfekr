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
    return TicTacToePeaceModel(
      id: id,
      currentStatuses: [PeaceStatusTypes.selected],
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
}
