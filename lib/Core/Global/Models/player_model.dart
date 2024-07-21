import 'package:kafehfekr/Core/Global/Models/status_types.dart';

class PlayerModel {
  final int id;
  final String name;
  final int? reactionId;

  PlayerModel({
    required this.id,
    required this.name,
    this.reactionId,
  });

  factory PlayerModel.fromJson(Map data) {
    return PlayerModel(
      id: data['id'],
      name: data['name'],
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
        reactionId: reactionId ?? this.reactionId,
      );

  PlayerModel changeReactionId({
    int? reactionId,
  }) {
    return PlayerModel(
      id: id,
      name: name,
      reactionId: reactionId,
    );
  }
}
