import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Yinsh/Controllers/yinsh_controller.dart';
import 'package:kafehfekr/Games/Yinsh/Widgets/yinsh_board_widget.dart';

class YinshPage extends BaseView<YinshController> {
  const YinshPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 15),
          if (controller.players.length > 1)
            Column(
              children: [
                GlobalMultyGameDataWidget(
                  playersData: controller.players.value,
                  timerColor: controller.returnTimerColor(),
                  activePlayerIndexes: const [1, 2],
                  currentTurn: 0,
                  usersNum1: [
                    controller.player1Score.value,
                    controller.player2Score.value,
                  ],
                  usersNum2: [
                    controller.player1Rings.value,
                    controller.player2Rings.value,
                  ],
                ),
                Container(
                  margin: AppSpacings.s5Top,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'دیسک : ',
                        style: TextStyle(
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 16,
                          foreground: Paint()
                            ..strokeWidth = 1.5
                            ..color = AppColors.lightColor
                            ..style = PaintingStyle.stroke,
                        ),
                      ),
                      Text(
                        controller.remainingDisks.value.toString(),
                        style: TextStyle(
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 20,
                          foreground: Paint()
                            ..strokeWidth = 1.5
                            ..color = AppColors.lightColor
                            ..style = PaintingStyle.stroke,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                YinshBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<YinshController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
