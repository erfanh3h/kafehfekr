import 'package:kafehfekr/Feature/General/Models/lobby_model.dart';
import 'package:kafehfekr/Feature/General/Models/queuer_model.dart';

class DetailedLobbyModel extends LobbyModel {
  final List<QueuerModel> queuers;

  DetailedLobbyModel({
    required this.queuers,
    required super.lobbyId,
    required super.lobbyName,
    required super.creatorId,
    required super.gameTypes,
    required super.queuersLength,
  });

  factory DetailedLobbyModel.fromJson(Map data) {
    List<QueuerModel> queuers = [];
    for (var element in data['queuers']) {
      queuers.add(QueuerModel.fromLobbyJson(element));
    }
    return DetailedLobbyModel(
      lobbyId: data['lobby_id'],
      lobbyName: data['lobby_name'],
      creatorId: data['creator_id'],
      gameTypes: List<String>.from(data['game_types']),
      queuers: queuers,
      queuersLength: queuers.length,
    );
  }

  @override
  DetailedLobbyModel copyWith({
    final String? lobbyId,
    final String? lobbyName,
    final String? creatorId,
    final List<String>? gameTypes,
    final List<QueuerModel>? queuers,
    final int? queuersLength,
  }) =>
      DetailedLobbyModel(
        lobbyId: lobbyId ?? this.lobbyId,
        lobbyName: lobbyName ?? this.lobbyName,
        creatorId: creatorId ?? this.creatorId,
        gameTypes: gameTypes ?? this.gameTypes,
        queuers: queuers ?? this.queuers,
        queuersLength: queuersLength ?? this.queuersLength,
      );
}
