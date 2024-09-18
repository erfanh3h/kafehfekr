import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class FekrBekrPeaceModel extends PeaceModel {
  FekrBekrPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.value,
  });

  int? value;


  FekrBekrPeaceModel changeValue({
    int? newValue,
  }) {
    return FekrBekrPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      value: newValue,
    );
  }

  FekrBekrPeaceModel resetPeace() {
    return FekrBekrPeaceModel(
      id: id,
      currentStatuses: [],
      value: null,
    );
  }

  @override
  FekrBekrPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return FekrBekrPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
    );
  }

  @override
  FekrBekrPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return FekrBekrPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      value: value,
    );
  }
}
