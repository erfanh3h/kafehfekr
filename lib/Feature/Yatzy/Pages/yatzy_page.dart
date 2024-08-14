import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_board_widget.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_interaction_widget.dart';

class YatzyPage extends BaseView<YatzyController> {
  const YatzyPage({super.key});

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
              roundText: "12 / ${controller.currentTurn}",
            ),
          const Spacer(flex: 3),
          if (controller.player1Pieces.length == 12 &&
              controller.player2Pieces.length == 12)
            YatzyBoardWidget(controller: controller),
          YatzyInteractionWidget(controller: controller),
          const Spacer(flex: 4),
          GlobalActivityBox<YatzyController>(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
