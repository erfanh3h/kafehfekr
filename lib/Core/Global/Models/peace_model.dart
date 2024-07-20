import 'package:kafehfekr/Core/Global/Models/status_types.dart';

class PeaceModel {
  final int id;
  final List<PeaceStatusTypes> currentStatuses;
  final String? value;

  PeaceModel({
    required this.id,
    required this.currentStatuses,
    this.value,
  });

  factory PeaceModel.fromJson(Map data) {
    return PeaceModel(
      id: data['id'],
      currentStatuses: [],
    );
  }

  PeaceModel copyWith({
    final int? id,
    final List<PeaceStatusTypes>? currentStatuses,
    final String? value,
  }) =>
      PeaceModel(
        id: id ?? this.id,
        currentStatuses: currentStatuses ?? this.currentStatuses,
        value: value ?? this.value,
      );

  PeaceModel addStatus({
    required final PeaceStatusTypes status,
  }) {
    List<PeaceStatusTypes> newStatuses = [];
    for (var oldStatus in currentStatuses) {
      newStatuses.add(oldStatus);
    }
    newStatuses.add(status);
    return PeaceModel(
      id: id,
      currentStatuses: newStatuses,
    );
  }

  PeaceModel removeStatus({
    required final PeaceStatusTypes status,
  }) {
    currentStatuses.remove(status);
    List<PeaceStatusTypes> newStatuses = [];
    for (var oldStatus in currentStatuses) {
      newStatuses.add(oldStatus);
    }
    return PeaceModel(
      id: id,
      currentStatuses: newStatuses,
    );
  }

  PeaceModel changevalue({
    String? newValue,
  }) {
    return PeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      value: newValue,
    );
  }
}
