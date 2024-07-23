import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class PeaceModel {
  final int id;
  final List<PeaceStatusTypes> currentStatuses;

  PeaceModel({
    required this.id,
    required this.currentStatuses,
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
  }) =>
      PeaceModel(
        id: id ?? this.id,
        currentStatuses: currentStatuses ?? this.currentStatuses,
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
}
