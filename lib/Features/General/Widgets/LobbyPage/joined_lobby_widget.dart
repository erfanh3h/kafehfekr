import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/chat_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Models/lobby_model.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_activity_box.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_user_row_data_widget.dart';
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
          GlobalFrameWrapper(
            frame: AppImages.bilboard2,
            height: 125,
            width: Get.size.width / 2,
            child: Padding(
              padding: AppSpacings.s30Top,
              child: Center(
                child: Text(
                  AppTexts.lobby.tr,
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 40,
                    fontFamily: FontFamilies.hekayat,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GlobalFrameWrapper(
            frame: AppImages.frame4,
            width: Get.size.width * 3 / 4,
            child: Row(
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
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: GlobalFrameWrapper(
                    frame: AppImages.board,
                    padding: AppSpacings.s30All,
                    child: ListView.separated(
                      itemBuilder: (ctx, index) => ChatBox(
                        chatData: controller.joinedLobbyChats[
                            controller.joinedLobbyChats.length - 1 - index],
                      ),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 20),
                      itemCount: controller.joinedLobbyChats.length,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: List.generate(
                      controller.joinedLobby.value!.lobbyCount,
                      (index) {
                        Rx<QueuerModel?> item = Rx(null);
                        if (index <
                            controller.joinedLobbyQueuers.value.length) {
                          item = controller.joinedLobbyQueuers.value[index];
                        }
                        return Obx(
                          () => LobbyUserRowData(
                            playerData: item.value,
                            onKick: controller.kickPlayer,
                            isMyLobby: controller.isMyLobby(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
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
