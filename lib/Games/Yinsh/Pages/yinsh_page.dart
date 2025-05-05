import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
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
                GlobalGameDataWidget(
                  player1Data: controller.players[0].value,
                  player2Data: controller.players[1].value,
                  timerColor: controller.returnTimerColor(),
                  player1Number1: controller.player1Score.value,
                  player2Number1: controller.player2Score.value,
                  player1Number2: controller.player1Rings.value,
                  player2Number2: controller.player2Rings.value,
                  // player1Number2: controller.player1Peaces.value -
                  //     controller.player1PlayedPeaces.value,
                  // player2Number2: controller.player2Peaces.value -
                  //     controller.player2PlayedPeaces.value,
                  // player1Number3: controller.players[0].value.notPlayedTurns,
                  // player2Number3: controller.players[1].value.notPlayedTurns,
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
