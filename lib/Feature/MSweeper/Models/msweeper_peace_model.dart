import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';

class MSweeperPeaceModel extends PeaceModel {
  MSweeperPeaceModel({
    required super.id,
    required super.currentStatuses,
    required this.sweeperStatuses,
    this.value,
  });

  int? value;
  List<MineSweeperStatusTypes> sweeperStatuses;

  MSweeperPeaceModel changeValue({
    int? newValue,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: newValue,
    );
  }

  MSweeperPeaceModel addSweeperStatus({
    required MineSweeperStatusTypes newStatus,
  }) {
    List<MineSweeperStatusTypes> newSweeperStatuses =[];
    for (var status in sweeperStatuses) {
      newSweeperStatuses.add(status);
    }
    newSweeperStatuses.add(newStatus);
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      sweeperStatuses: newSweeperStatuses,
    );
  }

  MSweeperPeaceModel removeSweeperStatus({
    required MineSweeperStatusTypes newStatus,
  }) {
    List<MineSweeperStatusTypes> newSweeperStatuses =[];
    for (var status in sweeperStatuses) {
      newSweeperStatuses.add(status);
    }
    newSweeperStatuses.remove(newStatus);
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      sweeperStatuses: newSweeperStatuses,
    );
  }

  MSweeperPeaceModel resetPeace() {
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: [],
      sweeperStatuses: [],
      value: null,
    );
  }

  @override
  MSweeperPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: value,
    );
  }

  @override
  MSweeperPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return MSweeperPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: value,
    );
  }
}
