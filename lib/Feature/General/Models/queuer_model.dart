class QueuerModel {
  final String userId;
  final int userImage;
  final String name;
  final bool? isRdy;
  final int? reactionId;

  QueuerModel({
    required this.userId,
    required this.userImage,
    required this.name,
    this.reactionId,
    this.isRdy,
  });

  factory QueuerModel.fromJson(Map data) {
    return QueuerModel(
      userId: data['user_id'],
      userImage: data['image'],
      name: data['name'],
    );
  }

  factory QueuerModel.fromLobbyJson(Map data) {
    return QueuerModel(
      userId: data['user_id'],
      userImage: data['image'],
      name: data['name'],
      isRdy: data['is_rdy']
    );
  }

  QueuerModel copyWith({
    final String? userId,
    final int? userImage,
    final String? name,
    final int? reactionId,
  }) =>
      QueuerModel(
        userId: userId ?? this.userId,
        userImage: userImage ?? this.userImage,
        name: name ?? this.name,
        reactionId: reactionId ?? this.reactionId,
      );

  QueuerModel changeReactionId({
    int? newReactionId,
  }) {
    return QueuerModel(
      userId: userId,
      userImage: userImage,
      name: name,
      reactionId: newReactionId,
    );
  }
}
