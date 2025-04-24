import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

enum RPCPeaceTypes { rock, paper, cutter }

class RPCPeaceModel extends PeaceModel {
  RPCPeaceModel({
    required super.id,
    required super.currentStatuses,
    required this.peaceType,
    this.selectedUser,
  });

  RPCPeaceTypes peaceType;

  int? selectedUser;

  RPCPeaceModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return RPCPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedUser: newSelectedUser,
      peaceType: peaceType,
    );
  }

  RPCPeaceModel resetPeace() {
    return RPCPeaceModel(
      id: id,
      currentStatuses: [],
      selectedUser: null,
      peaceType: RPCPeaceTypes.rock,
    );
  }

  @override
  RPCPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return RPCPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      peaceType: peaceType,
    );
  }

  @override
  RPCPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return RPCPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedUser: selectedUser,
      peaceType: peaceType,
    );
  }
}
