import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';

class SudokuPeaceModel extends PeaceModel {
  SudokuPeaceModel({
    required super.id,
    required super.currentStatuses,
    required this.sweeperStatuses,
    this.value,
  });

  int? value;
  List<MineSweeperStatusTypes> sweeperStatuses;

  factory SudokuPeaceModel.fromJson(Map data, int id) {
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
    return SudokuPeaceModel(
      id: id,
      currentStatuses: peaceStatusList,
      sweeperStatuses: sweeperStatusList,
      value: newValue,
    );
  }
  SudokuPeaceModel changeValue({
    int? newValue,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return SudokuPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: newValue,
    );
  }

  SudokuPeaceModel addSweeperStatus({
    required MineSweeperStatusTypes newStatus,
  }) {
    List<MineSweeperStatusTypes> newSweeperStatuses = [];
    for (var status in sweeperStatuses) {
      newSweeperStatuses.add(status);
    }
    newSweeperStatuses.add(newStatus);
    return SudokuPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      sweeperStatuses: newSweeperStatuses,
    );
  }

  SudokuPeaceModel removeSweeperStatus({
    required MineSweeperStatusTypes newStatus,
  }) {
    List<MineSweeperStatusTypes> newSweeperStatuses = [];
    for (var status in sweeperStatuses) {
      newSweeperStatuses.add(status);
    }
    newSweeperStatuses.remove(newStatus);
    return SudokuPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      sweeperStatuses: newSweeperStatuses,
    );
  }

  SudokuPeaceModel resetPeace() {
    return SudokuPeaceModel(
      id: id,
      currentStatuses: [],
      sweeperStatuses: [],
      value: null,
    );
  }

  @override
  SudokuPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return SudokuPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: value,
    );
  }

  @override
  SudokuPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return SudokuPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      sweeperStatuses: sweeperStatuses,
      value: value,
    );
  }
}
