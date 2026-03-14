import 'package:animate_do/animate_do.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_offline_games_activity_buttons.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_offline_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Widgets/tictactoe_offline_board_widget.dart';

class TicTacToeOfflinePage extends BaseView<TicTacToeOfflineController> {
  const TicTacToeOfflinePage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        controller.isGameFinished.value
            ? GlobalFrameWrapper(
                frame: AppImages.frame3,
                padding: AppSpacings.s20Vertical50Horizental,
                child: Text(
                  controller.gameResultText.value,
                  style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.lightColor,
                  ),
                ),
              )
            : GlobalFrameWrapper(
                frame: AppImages.frame3,
                padding: AppSpacings.s20Vertical50Horizental,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "نوبت: ",
                      style: TextStyle(
                        fontSize: 25,
                        color: AppColors.lightColor,
                      ),
                    ),
                    ElasticIn(
                      child: Image.asset(
                        controller.currentTurn.value == 1
                            ? GeneralIcons.circle1
                            : GeneralIcons.cross,
                        color: controller.currentTurn.value == 1
                            ? AppColors.darkRed
                            : AppColors.imageBlueColor,
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                ),
              ),
        const SizedBox(height: 20),
        TicTacToeOfflineBoardWidget(controller: controller),
        Spacer(),
        Padding(
          padding: AppSpacings.s10Bottom,
          child: OfflineActivityButtons(controller: controller),
        ),
      ],
    );
  }
}
