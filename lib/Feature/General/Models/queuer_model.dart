class QueuerModel {
  final String userId;
  final int userImage;
  final String name;
  final int? reactionId;

  QueuerModel({
    required this.userId,
    required this.userImage,
    required this.name,
    this.reactionId,
  });

  factory QueuerModel.fromJson(Map data) {
    return QueuerModel(
      userId: data['user_id'],
      userImage: data['image'],
      name: data['name'],
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
