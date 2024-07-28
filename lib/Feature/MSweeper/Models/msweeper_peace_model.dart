import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class MSweeperPeaceModel extends PeaceModel {
  MSweeperPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.value,
    this.isMine= false,
  });

  int? value;
  bool isMine;

  MSweeperPeaceModel changeValue({
    int? newValue,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      value: newValue,
    );
  }

  MSweeperPeaceModel changeMineValue({
    required bool isMineValue,
  }) {
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      isMine: isMineValue,
    );
  }

  MSweeperPeaceModel resetPeace() {
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: [],
      value: null,
    );
  }

  @override
  MSweeperPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
    );
  }

  @override
  MSweeperPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
    );
  }
}
