import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class SudokuPeaceModel extends PeaceModel {
  SudokuPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.isBaseNumber = false,
    this.value = 0,
  });

  int value;
  bool isBaseNumber;

  factory SudokuPeaceModel.fromJson(Map data, int id) {
    return SudokuPeaceModel(
      id: id,
      currentStatuses: [],
      value: data['number'],
      isBaseNumber: data['is_base_number'],
    );
  }
  SudokuPeaceModel changeValue({
    required int newValue,
    bool? isBaseNumber,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return SudokuPeaceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      value: newValue,
      isBaseNumber: isBaseNumber ?? this.isBaseNumber,
    );
  }

  SudokuPeaceModel resetPeace() {
    return SudokuPeaceModel(
      id: id,
      currentStatuses: [],
      value: 0,
      isBaseNumber: false,
    );
  }

  @override
  SudokuPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return SudokuPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
      isBaseNumber: isBaseNumber,
    );
  }

  @override
  SudokuPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return SudokuPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
      isBaseNumber: isBaseNumber,
    );
  }
}
