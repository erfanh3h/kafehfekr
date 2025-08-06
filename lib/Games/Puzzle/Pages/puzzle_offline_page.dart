import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Puzzle/Controllers/puzzle_offline_controller.dart';
import 'package:kafehfekr/Games/Puzzle/Widgets/puzzle_offline_board_widget.dart';
import 'package:refreshed/refreshed.dart';

class PuzzleOfflinePage extends BaseView<PuzzleOfflineController> {
  const PuzzleOfflinePage({super.key});
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
            child: Text(
              'تعداد حرکت : ${controller.moveCount}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.lightColor,
              ),
            ),
          ),
        ),
        const Spacer(),
        PuzzleOfflineBoardWidget(controller: controller),
        const Spacer(),
        Padding(
          padding: AppSpacings.s10Bottom,
          child: OfflineActivityButtons(controller: controller),
        ),
      ],
    );
  }
}
