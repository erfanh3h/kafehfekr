class PlayerModel {
  final String userId;
  final int gamerId;
  final String name;
  final int disconnectTime;
  final bool isDisconnected;
  final int? reactionId;

  PlayerModel({
    required this.userId,
    required this.gamerId,
    required this.name,
    required this.disconnectTime,
    this.isDisconnected = false,
    this.reactionId,
  });

  factory PlayerModel.fromJson(Map data) {
    return PlayerModel(
      userId: data['user_id'],
      gamerId: data['gamer_id'],
      name: data['name'],
      disconnectTime: data['remain_dc_time'],
      isDisconnected: data['is_disconnected'],
    );
  }

  PlayerModel copyWith({
    final String? userId,
    final int? gamerId,
    final String? name,
    final int? reactionId,
    final int? disconnectTime,
    final bool? isDisconnected,
  }) =>
      PlayerModel(
        userId: userId ?? this.userId,
        gamerId: gamerId ?? this.gamerId,
        name: name ?? this.name,
        reactionId: reactionId ?? this.reactionId,
        disconnectTime: disconnectTime ?? this.disconnectTime,
        isDisconnected: isDisconnected ?? this.isDisconnected,
      );

  PlayerModel changeReactionId({
    int? newReactionId,
  }) {
    return PlayerModel(
      userId: userId,
      gamerId: gamerId,
      name: name,
      reactionId: newReactionId,
      disconnectTime: disconnectTime,
    );
  }
}
