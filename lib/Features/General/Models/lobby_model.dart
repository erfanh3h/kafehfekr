class LobbyModel {
  final String lobbyId;
  final String lobbyName;
  final String creatorId;
  final String gameType;
  final int queuersLength;
  final int lobbyCount;

  LobbyModel({
    required this.lobbyId,
    required this.lobbyName,
    required this.creatorId,
    required this.gameType,
    required this.queuersLength,
    required this.lobbyCount,
  });

  factory LobbyModel.fromJson(Map data) {
    return LobbyModel(
      lobbyId: data['lobby_id'],
      lobbyName: data['lobby_name'],
      creatorId: data['creator_id'],
      gameType: data['game_type'],
      queuersLength: data['queuers_length'],
      lobbyCount: data['lobby_count'],
    );
  }

  LobbyModel copyWith({
    String? lobbyId,
    String? lobbyName,
    String? creatorId,
    String? gameType,
    int? queuersLength,
    int? lobbyCount,
  }) =>
      LobbyModel(
        lobbyId: lobbyId ?? this.lobbyId,
        lobbyName: lobbyName ?? this.lobbyName,
        creatorId: creatorId ?? this.creatorId,
        gameType: gameType ?? this.gameType,
        queuersLength: queuersLength ?? this.queuersLength,
        lobbyCount: lobbyCount ?? this.lobbyCount,
      );
}
