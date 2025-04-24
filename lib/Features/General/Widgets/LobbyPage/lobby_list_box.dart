import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_room_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class LobbyListBox extends StatelessWidget {
  const LobbyListBox({
    super.key,
    required this.controller,
  });

  final LobbyController controller;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.requestData(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: AppSpacings.s20Top,
            child: Center(
              child: Text(
                AppTexts.lobbyList.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 28,
                  fontFamily: FontFamilies.dastnevis,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: AppSpacings.s20Horizental,
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (ctx, index) => LobbyRoomRowWidget(
                    lobby: controller.lobbies[index],
                    onJoin: controller.onJoinLobby,
                  ),
                  itemCount: controller.lobbies.length,
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1.5,
            child: LobbyActivityBox(controller: controller),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
