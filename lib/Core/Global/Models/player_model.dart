import 'package:kafehfekr/Core/Global/Models/status_types.dart';

class PlayerModel {
  final int id;
  final String name;
  final List<PlayerStatusTypes> currentStatuses;
  final int? reactionId;

  PlayerModel({
    required this.id,
    required this.name,
    required this.currentStatuses,
    this.reactionId,
  });

  factory PlayerModel.fromJson(Map data) {
    return PlayerModel(
      id: data['id'],
      name: data['name'],
      currentStatuses: [],
    );
  }

  PlayerModel copyWith({
    final int? id,
    final String? name,
    final List<PlayerStatusTypes>? currentStatuses,
    final int? reactionId,
  }) =>
      PlayerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        currentStatuses: currentStatuses ?? this.currentStatuses,
        reactionId: reactionId ?? this.reactionId,
      );

  PlayerModel addStatus({
    required final PlayerStatusTypes status,
  }) {
    List<PlayerStatusTypes> newStatuses = [];
    for (var oldStatus in currentStatuses) {
      newStatuses.add(oldStatus);
    }
    newStatuses.add(status);
    return PlayerModel(
      id: id,
      name: name,
      currentStatuses: newStatuses,
    );
  }

  PlayerModel removeStatus({
    required final PlayerStatusTypes status,
  }) {
    currentStatuses.remove(status);
    List<PlayerStatusTypes> newStatuses = [];
    for (var oldStatus in currentStatuses) {
      newStatuses.add(oldStatus);
    }
    return PlayerModel(
      id: id,
      name: name,
      currentStatuses: newStatuses,
    );
  }

  PlayerModel changeReactionId({
    int? reactionId,
  }) {
    return PlayerModel(
      id: id,
      name: name,
      currentStatuses: currentStatuses,
      reactionId: reactionId,
    );
  }
}
