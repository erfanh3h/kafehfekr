import 'package:kafehfekr/Feature/General/Models/queuer_model.dart';

class LobbyModel {
  final String lobbyId;
  final String lobbyName;
  final String creatorId;
  final List<String> gameTypes;
  final List<QueuerModel> queuers;

  LobbyModel({
    required this.lobbyId,
    required this.lobbyName,
    required this.creatorId,
    required this.gameTypes,
    required this.queuers,
  });

  factory LobbyModel.fromJson(Map data) {
    List<QueuerModel> queuers = [];
    for (var element in data['queuers']) {
      queuers.add(QueuerModel.fromLobbyJson(element));
    }
    return LobbyModel(
      lobbyId: data['lobby_id'],
      lobbyName: data['lobby_name'],
      creatorId: data['creator_id'],
      gameTypes: List<String>.from(data['game_types']),
      queuers: queuers,
    );
  }

  LobbyModel copyWith({
    final String? lobbyId,
    final String? lobbyName,
    final String? creatorId,
    final List<String>? gameTypes,
    final List<QueuerModel>? queuers,
  }) =>
      LobbyModel(
        lobbyId: lobbyId ?? this.lobbyId,
        lobbyName: lobbyName ?? this.lobbyName,
        creatorId: creatorId ?? this.creatorId,
        gameTypes: gameTypes ?? this.gameTypes,
        queuers: queuers ?? this.queuers,
      );
}
