import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BattleShipGamePieceModel extends PeaceModel {
  BattleShipGamePieceModel({
    required super.id,
    required super.currentStatuses,
    this.number = 0,
    this.isSelected = false,
  });

  int number;
  bool isSelected;

  BattleShipGamePieceModel getFromJson(Map data, int id) {
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: currentStatuses,
      number: data['number'],
      isSelected: data['is_selected'],
    );
  }

  BattleShipGamePieceModel changeSelectedUser({
    int? number,
    bool? isSelected,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      number: number ?? this.number,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  BattleShipGamePieceModel resetPeace() {
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: [],
      number: 0,
      isSelected: false,
    );
  }

  @override
  BattleShipGamePieceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BattleShipGamePieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      number: number,
      isSelected: isSelected,
    );
  }

  @override
  BattleShipGamePieceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BattleShipGamePieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      number: number,
      isSelected: isSelected,
    );
  }
}
