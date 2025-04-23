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

  factory MSweeperPeaceModel.fromJson(Map data, int id) {
    List<PeaceStatusTypes> peaceStatusList = [];
    List<MineSweeperStatusTypes> sweeperStatusList = [];
    int? newValue;
    if (data['selected']) {
      peaceStatusList.add(PeaceStatusTypes.selected);
      newValue = data['value'];
    }
    if (data['correctly_selected_mine']) {
      sweeperStatusList.add(MineSweeperStatusTypes.isCorrectlySelectedAsMine);
    }
    if (data['wrongly_selected_mine']) {
      sweeperStatusList.add(MineSweeperStatusTypes.isWronglySelectedAsMine);
    }
    if (data['hitted_mine']) {
      sweeperStatusList.add(MineSweeperStatusTypes.isExplodedMine);
    }
    if (data['mine']) {
      newValue = -1;
      sweeperStatusList.add(MineSweeperStatusTypes.isMine);
    }
    return MSweeperPeaceModel(
      id: id,
      currentStatuses: peaceStatusList,
      sweeperStatuses: sweeperStatusList,
      value: newValue,
    );
  }
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
    List<MineSweeperStatusTypes> newSweeperStatuses = [];
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
    List<MineSweeperStatusTypes> newSweeperStatuses = [];
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
        id: id, currentStatuses: [], sweeperStatuses: [], value: null);
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
