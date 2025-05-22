import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_page_header.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_room_row_widget.dart';
import 'package:refreshed/refreshed.dart';

class LobbyListBox extends BaseView<LobbyController> {
  const LobbyListBox({super.key});

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: controller.createLobby,
      child: const Icon(
        Icons.add,
        color: AppColors.lightColor,
      ),
    );
  }

  @override
  String? backgroundImage() {
    return AppImages.background3;
  }

  @override
  Widget body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.requestData();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          GlobalPageHeader(label: AppTexts.lobby.tr),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: AppSpacings.s20Horizental,
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (ctx, index) => Obx(
                    () => LobbyRoomRowWidget(
                      lobby: controller.lobbies[index].value,
                      onJoin: controller.onJoinLobby,
                    ),
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
