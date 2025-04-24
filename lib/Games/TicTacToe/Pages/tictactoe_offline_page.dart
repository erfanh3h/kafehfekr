import 'package:animate_do/animate_do.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_offline_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Widgets/tictactoe_offline_board_widget.dart';
import 'package:refreshed/get_utils/get_utils.dart';

class TicTacToeOfflinePage extends BaseView<TicTacToeOfflineController> {
  const TicTacToeOfflinePage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: controller.isGameFinished.value
                ? Center(
                    child: Text(
                      controller.gameResultText.value,
                      style: const TextStyle(
                        fontSize: 25,
                        color: AppColors.lightColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              ? AppColors.imageRedColor
                              : AppColors.imageBlueColor,
                          width: 50,
                          height: 50,
                        ),
                      )
                    ],
                  ),
          ),
          Expanded(
            flex: 3,
            child: TicTacToeOfflineBoardWidget(controller: controller),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (controller.isGameFinished.value)
                  GlobalButtonWidget(
                    onTap: controller.resetGame,
                    text: AppTexts.restart.tr,
                  ),
                GlobalButtonWidget(
                  onTap: controller.exitGame,
                  text: AppTexts.exit.tr,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
