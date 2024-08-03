class PlayerModel {
  final String userId;
  final int gamerId;
  final String name;
  final int? reactionId;

  PlayerModel({
    required this.userId,
    required this.gamerId,
    required this.name,
    this.reactionId,
  });

  factory PlayerModel.fromJson(Map data) {
    return PlayerModel(
      userId: data['user_id'],
      gamerId: data['gamer_id'],
      name: data['name'],
    );
  }

  PlayerModel copyWith({
    final String? userId,
    final int? gamerId,
    final String? name,
    final int? reactionId,
  }) =>
      PlayerModel(
        userId: userId ?? this.userId,
        gamerId: gamerId ?? this.gamerId,
        name: name ?? this.name,
        reactionId: reactionId ?? this.reactionId,
      );

  PlayerModel changeReactionId({
    int? newReactionId,
  }) {
    return PlayerModel(
      userId: userId,
      gamerId: gamerId,
      name: name,
      reactionId: newReactionId,
    );
  }
}
