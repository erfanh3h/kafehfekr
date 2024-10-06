
class LobbyModel {
  final String lobbyId;
  final String lobbyName;
  final String creatorId;
  final List<String> gameTypes;
  final int queuersLength;

  LobbyModel({
    required this.lobbyId,
    required this.lobbyName,
    required this.creatorId,
    required this.gameTypes,
    required this.queuersLength,
  });

  factory LobbyModel.fromJson(Map data) {
    return LobbyModel(
      lobbyId: data['lobby_id'],
      lobbyName: data['lobby_name'],
      creatorId: data['creator_id'],
      gameTypes: List<String>.from(data['game_types']),
      queuersLength: data['queuers_length'],
    );
  }

  LobbyModel copyWith({
    final String? lobbyId,
    final String? lobbyName,
    final String? creatorId,
    final List<String>? gameTypes,
    final int? queuersLength,
  }) =>
      LobbyModel(
        lobbyId: lobbyId ?? this.lobbyId,
        lobbyName: lobbyName ?? this.lobbyName,
        creatorId: creatorId ?? this.creatorId,
        gameTypes: gameTypes ?? this.gameTypes,
        queuersLength: queuersLength ?? this.queuersLength,
      );
}
