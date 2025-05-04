class PlayerModel {
  final String userId;
  final int gamerId;
  final int userImage;
  final String name;
  final int notPlayedTurns;
  final bool isDisconnected;
  final int? reactionId;

  PlayerModel({
    required this.userId,
    required this.gamerId,
    required this.userImage,
    required this.name,
    required this.notPlayedTurns,
    this.isDisconnected = false,
    this.reactionId,
  });

  factory PlayerModel.fromJson(Map data) {
    return PlayerModel(
      userId: data['user_id'],
      gamerId: data['gamer_id'],
      userImage: data['user_image'],
      name: data['name'],
      notPlayedTurns: data['not_played_turns'],
      isDisconnected: data['is_disconnected'],
    );
  }

  PlayerModel copyWith({
    final String? userId,
    final int? gamerId,
    final int? userImage,
    final String? name,
    final int? reactionId,
    final int? notPlayedTurns,
    final bool? isDisconnected,
  }) =>
      PlayerModel(
        userId: userId ?? this.userId,
        gamerId: gamerId ?? this.gamerId,
        userImage: userImage ?? this.userImage,
        name: name ?? this.name,
        reactionId: reactionId ?? this.reactionId,
        notPlayedTurns: notPlayedTurns ?? this.notPlayedTurns,
        isDisconnected: isDisconnected ?? this.isDisconnected,
      );

  PlayerModel changeReactionId({
    int? newReactionId,
  }) {
    return PlayerModel(
      userId: userId,
      gamerId: gamerId,
      userImage: userImage,
      name: name,
      reactionId: newReactionId,
      notPlayedTurns: notPlayedTurns,
      isDisconnected: isDisconnected,
    );
  }

  factory PlayerModel.fromOfflineGame(int gamerId) {
    return PlayerModel(
      userId: gamerId.toString(),
      gamerId: gamerId,
      userImage: 0,
      name: 'بازیکن $gamerId',
      notPlayedTurns: 0,
      isDisconnected: false,
    );
  }
}
