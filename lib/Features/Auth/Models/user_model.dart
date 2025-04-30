class UserModel {
  final String id;
  final String phone;
  final int score;
  final int xp;
  final String name;
  final int image;
  final int coin;
  final String openGameId;
  final String openPreGameId;

  final DateTime joinDate;
  final DateTime lastTimeChance;

  UserModel({
    required this.id,
    required this.phone,
    required this.score,
    required this.xp,
    required this.name,
    required this.image,
    required this.coin,
    required this.openGameId,
    required this.openPreGameId,
    required this.joinDate,
    required this.lastTimeChance,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      id: data['_id'],
      phone: data['phone'] ?? "",
      score: data['score'] ?? 0,
      xp: data['xp'] ?? 0,
      name: data['username'] ?? "",
      image: data['image'] ?? 0,
      coin: data['coin'] ?? 0,
      openGameId: data['open_game_id'] ?? "",
      openPreGameId: data['open_pre_game_id'] ?? "",
      joinDate: DateTime.tryParse(data['join_date'] ?? "") ?? DateTime.now(),
      lastTimeChance:
          DateTime.tryParse(data['last_time_chance'] ?? "") ?? DateTime.now(),
    );
  }

  UserModel copyWith({
    final String? id,
    final String? phone,
    final int? score,
    final int? xp,
    final String? name,
    final int? image,
    final int? coin,
    final String? openGameId,
    final String? openPreGameId,
    final DateTime? joinDate,
    final DateTime? lastTimeChance,
  }) =>
      UserModel(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        score: score ?? this.score,
        xp: xp ?? this.xp,
        name: name ?? this.name,
        image: image ?? this.image,
        coin: coin ?? this.coin,
        openGameId: openGameId ?? this.openGameId,
        openPreGameId: openPreGameId ?? this.openPreGameId,
        joinDate: joinDate ?? this.joinDate,
        lastTimeChance: lastTimeChance ?? this.lastTimeChance,
      );
}
