import 'package:flutter/material.dart';
import 'package:kafehfekr/Feature/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Feature/General/Models/detailed_lobby_model.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/lobby_users_data_widget.dart';

class JoinedLobbyWidget extends StatelessWidget {
  const JoinedLobbyWidget({
    super.key,
    required this.lobby,
    required this.controller,
  });

  final DetailedLobbyModel lobby;
  final LobbyController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        LobbyUsersDataWidget(
          player1Data: lobby.queuers.isNotEmpty ? lobby.queuers.first : null,
          player2Data: lobby.queuers.length > 1 ? lobby.queuers[1] : null,
          creatorId: lobby.creatorId,
          onKick: (_) {},
        ),
        const Spacer(),
        LobbyActivityBox(controller: controller),
        const SizedBox(height: 15),
      ],
    );
  }
}
