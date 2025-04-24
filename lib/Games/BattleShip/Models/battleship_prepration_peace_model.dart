import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class BattleShipPreprationPeaceModel extends PeaceModel {
  BattleShipPreprationPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.shipId,
    this.nextPartId,
  });

  int? shipId;
  int? nextPartId;

  BattleShipPreprationPeaceModel changeshipId({
    int? newshipId,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BattleShipPreprationPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      shipId: newshipId,
      nextPartId: nextPartId,
    );
  }

  BattleShipPreprationPeaceModel changenextPartId({
    required int newNextPartId,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return BattleShipPreprationPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      shipId: shipId,
      nextPartId: newNextPartId,
    );
  }

  BattleShipPreprationPeaceModel resetPeace() {
    return BattleShipPreprationPeaceModel(
      id: id,
      currentStatuses: [],
      shipId: null,
      nextPartId: null,
    );
  }

  @override
  BattleShipPreprationPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return BattleShipPreprationPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      shipId: shipId,
      nextPartId: nextPartId,
    );
  }

  @override
  BattleShipPreprationPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return BattleShipPreprationPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      shipId: shipId,
      nextPartId: nextPartId,
    );
  }
}
