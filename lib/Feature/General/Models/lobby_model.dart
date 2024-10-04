class LobbyModel {
  final String lobbyId;
  final String lobbyName;
  final String creatorId;
  final List<String> gameTypes;

  LobbyModel({
    required this.lobbyId,
    required this.lobbyName,
    required this.creatorId,
    required this.gameTypes,
  });

  factory LobbyModel.fromJson(Map data) {
    return LobbyModel(
      lobbyId: data['user_id'],
      lobbyName: data['image'],
      creatorId: data['name'],
      gameTypes: data['name'],
    );
  }

  LobbyModel copyWith({
    final String? lobbyId,
    final String? lobbyName,
    final String? creatorId,
    final List<String>? gameTypes,
  }) =>
      LobbyModel(
        lobbyId: lobbyId ?? this.lobbyId,
        lobbyName: lobbyName ?? this.lobbyName,
        creatorId: creatorId ?? this.creatorId,
        gameTypes: gameTypes ?? this.gameTypes,
      );
}
