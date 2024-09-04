class UserModel {
  final String id;
  final String phone;
  final int score;
  final int xp;
  final String name;
  final int image;
  final int coin;
  final DateTime joinDate;

  UserModel({
    required this.id,
    required this.phone,
    required this.score,
    required this.xp,
    required this.name,
    required this.image,
    required this.coin,
    required this.joinDate,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      id: data['_id'],
      phone: data['phone'],
      score: data['score'],
      xp: data['xp'],
      name: data['username'],
      image: data['image'],
      coin: data['coin'],
      joinDate: DateTime.parse(data['join_date']),
    );
  }

  // UserModel copyWith({
  //   final String? userId,
  //   final int? score,
  //   final int? xp,
  //   final String? name,
  //   final int? reactionId,
  //   final int? image,
  //   final int? coin,
  //   final bool? joinDate,
  // }) =>
  //     UserModel(
  //       userId: userId ?? this.userId,
  //       score: score ?? this.score,
  //       xp: xp ?? this.xp,
  //       name: name ?? this.name,
  //       reactionId: reactionId ?? this.reactionId,
  //       image: image ?? this.image,
  //       coin: coin ?? this.coin,
  //       joinDate: joinDate ?? this.joinDate,
  //     );
}
