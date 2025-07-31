import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Games/RPC/Widgets/rpc_main_widget.dart';

class RPCPage extends BaseView<RPCController> {
  const RPCPage({super.key});
  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 15),
        if (controller.players.length > 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalMultyGameDataWidget(
                playersData: controller.players.value,
                timerColor: controller.returnTimerColor(),
                activePlayerIndexes: const [1, 2],
                currentTurn: controller.currentTurn.value,
                usersNum1: [
                  controller.player1RoundScore.value,
                  controller.player2RoundScore.value
                ],
                usersNum2: [
                  controller.player1TotalScore.value,
                  controller.player2TotalScore.value
                ],
                roundText:
                    "${controller.maxRound} / ${controller.currentRound}",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'دور : ',
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 13,
                      foreground: Paint()
                        ..strokeWidth = 1.5
                        ..color = AppColors.lightColor
                        ..style = PaintingStyle.stroke,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${controller.maxTurnRound} / ${controller.currentTurnRound.value}",
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 15,
                      foreground: Paint()
                        ..strokeWidth = 1.5
                        ..color = AppColors.lightColor
                        ..style = PaintingStyle.stroke,
                    ),
                  ),
                ],
              ),
            ],
          ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              if (controller.isGameStarted.value)
                RPCMainWidget(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GlobalActivityBox<RPCController>(),
        const SizedBox(height: 20),
      ],
    );
  }
}
