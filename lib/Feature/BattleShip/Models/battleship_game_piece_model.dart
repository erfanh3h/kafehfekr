import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BattleShipGamePieceModel extends PeaceModel {
  BattleShipGamePieceModel({
    required super.id,
    required super.currentStatuses,
    this.number = 0,
    this.isSelected = false,
    this.isShipCompleted = false,
  });

  int number;
  bool isSelected;
  bool isShipCompleted;

  BattleShipGamePieceModel getFromJson(Map data, int id) {
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: currentStatuses,
      number: data['number'],
      isSelected: data['is_selected'],
      isShipCompleted: isShipCompleted,
    );
  }

  BattleShipGamePieceModel changeNumber({
    int? number,
    bool isSelected = true,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      number: number ?? this.number,
      isSelected: isSelected,
      isShipCompleted: isShipCompleted,
    );
  }

  BattleShipGamePieceModel changeIsShipCompleted({
    required bool isShipCompleted,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      number: number,
      isSelected: isSelected,
      isShipCompleted: isShipCompleted,
    );
  }

  BattleShipGamePieceModel resetPeace() {
    return BattleShipGamePieceModel(
      id: id,
      currentStatuses: [],
      number: 0,
      isSelected: false,
      isShipCompleted: false,
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
      isShipCompleted: isShipCompleted,
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
      isShipCompleted: isShipCompleted,
    );
  }
}
