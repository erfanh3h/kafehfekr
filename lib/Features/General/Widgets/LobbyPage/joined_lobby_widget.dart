import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/chat_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Models/lobby_model.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_users_data_widget.dart';
import 'package:refreshed/refreshed.dart';

class JoinedLobbyWidget extends StatelessWidget {
  const JoinedLobbyWidget({
    super.key,
    required this.lobby,
    required this.controller,
  });

  final LobbyModel lobby;
  final LobbyController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.joinedLobby.value!.lobbyName,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 30,
                  fontFamily: FontFamilies.playPen,
                  // letterSpacing: 6,
                ),
              ),
              // const SizedBox(width: 25),
              Text(
                "  (${controller.joinedLobby.value!.gameType.tr})",
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 16,
                  fontFamily: FontFamilies.hekayat,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Builder(builder: (context) {
            return Obx(
              () => LobbyUsersDataWidget(
                playersData: controller.joinedLobbyQueuers.value,
                isMyLobby: controller.isMyLobby(),
                onKick: controller.kickPlayer,
                lobbyCount: controller.joinedLobby.value!.lobbyCount,
              ),
            );
          }),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, index) => ChatBox(
                chatData: controller.joinedLobbyChats[
                    controller.joinedLobbyChats.length - 1 - index],
              ),
              separatorBuilder: (ctx, index) => const SizedBox(height: 20),
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
