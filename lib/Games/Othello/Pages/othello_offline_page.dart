import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_offline_controller.dart';
import 'package:kafehfekr/Games/Othello/Widgets/othello_offline_board_widget.dart';
import 'package:refreshed/refreshed.dart';

class OthelloOfflinePage extends BaseView<OthelloOfflineController> {
  const OthelloOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Obx(
          () => GlobalFrameWrapper(
            frame: AppImages.frame3,
            padding: AppSpacings.s20Vertical40Horizental,
            child: Column(
              children: [
                Text(
                  controller.isGameOver.value
                      ? controller.winnerLabel.value
                      : 'نوبت: ${controller.currentPlayer.value == Disk.black ? 'سیاه' : 'سفید'}',
                  style: const TextStyle(
                      fontSize: 22, color: AppColors.lightColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'سیاه: ${controller.blackCount.value}   سفید: ${controller.whiteCount.value}',
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.lightColor),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        OthelloOfflineBoardWidget(controller: controller),
        const Spacer(),
        Padding(
          padding: AppSpacings.s10Bottom,
          child: OfflineActivityButtons(controller: controller),
        ),
      ],
    );
  }
}
