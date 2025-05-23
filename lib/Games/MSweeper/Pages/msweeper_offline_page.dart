import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/MSweeper/Controllers/msweeper_offline_controller.dart';
import 'package:kafehfekr/Games/MSweeper/Widgets/msweeper_offline_board_widget.dart';

class MSweeperOfflinePage extends BaseView<MSweeperOfflineController> {
  const MSweeperOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 10),
        GlobalFrameWrapper(
          frame: AppImages.frame3,
          width: 250,
          child: Center(
            child: Text(
              controller.isGameFinished.value
                  ? controller.gameResultText.value
                  : 'خانه ی باقیمانده  :  ${controller.allPiecesCount.value - controller.defusedPieces.value - controller.minesCount.value}',
              style: const TextStyle(
                fontFamily: FontFamilies.hekayat,
                fontSize: 25,
                color: AppColors.lightColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: MSweeperOfflineBoardWidget(controller: controller),
        ),
        Expanded(child: OfflineActivityButtons(controller: controller))
      ],
    );
  }
}
