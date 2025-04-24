import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MSweeper/Controllers/msweeper_controller.dart';
import 'package:kafehfekr/Games/MSweeper/Widgets/msweeper_board_widget.dart';

class MSweeperPage extends BaseView<MSweeperController> {
  const MSweeperPage({super.key});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            GlobalGameDataWidget(
              player1Data: controller.players[0].value,
              player2Data: controller.players[1].value,
              timerColor: controller.returnTimerColor(),
              player1Number1: controller.player1Score.value,
              player2Number1: controller.player2Score.value,
              // roundText: "${controller.selectMineRemainingCount.value}",
            ),
          Container(
            margin: AppSpacings.s5Top,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'انتخاب باقیمانده : ',
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 20,
                    foreground: Paint()
                      ..strokeWidth = 1.5
                      ..color = AppColors.lightColor
                      ..style = PaintingStyle.stroke,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "${controller.selectMineRemainingCount.value}",
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 30,
                    foreground: Paint()
                      ..strokeWidth = 1.5
                      ..color = AppColors.lightColor
                      ..style = PaintingStyle.stroke,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                MSweeperBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GlobalActivityBox<MSweeperController>(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
