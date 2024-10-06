import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/chat_box.dart';
import 'package:kafehfekr/Feature/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Feature/General/Models/detailed_lobby_model.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Feature/General/Widgets/LobbyPage/lobby_users_data_widget.dart';
import 'package:refreshed/refreshed.dart';

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
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 15),
          Builder(builder: (context) {
            return Obx(
              () => LobbyUsersDataWidget(
                player1Data:
                    lobby.queuers.isNotEmpty ? lobby.queuers.first : null,
                player2Data: lobby.queuers.length > 1 ? lobby.queuers[1] : null,
                isMyLobby: controller.isMyLobby(),
                onKick: controller.kickPlayer,
                isPlayer1Rdy: controller.isPlayer1Rdy.value,
                isPlayer2Rdy: controller.isPlayer2Rdy.value,
              ),
            );
          }),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => ChatBox(
                isLeft: controller.joinedLobbyChats[index].$1,
                index: controller.joinedLobbyChats[index].$2,
              ),
              itemCount: controller.joinedLobbyChats.length,
            ),
          ),
          const SizedBox(height: 10),
          LobbyActivityBox(controller: controller),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
