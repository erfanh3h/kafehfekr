import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Games/Yatzy/Widgets/yatzy_board_widget.dart';
import 'package:kafehfekr/Games/Yatzy/Widgets/yatzy_interaction_widget.dart';

class YatzyPage extends BaseView<YatzyController> {
  const YatzyPage({super.key});
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
          GlobalMultyGameDataWidget(
            playersData: controller.players.value,
            timerColor: controller.returnTimerColor(),
            activePlayerIndexes: const [1, 2],
            currentTurn: 0,
            usersNum1: [
              controller.player1Score.value,
              controller.player2Score.value,
            ],
            roundText: "12 / ${controller.currentTurn}",
          ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              if (controller.player1Pieces.length == 12 &&
                  controller.player2Pieces.length == 12)
                YatzyBoardWidget(controller: controller),
              YatzyInteractionWidget(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GlobalActivityBox<YatzyController>(),
        const SizedBox(height: 20),
      ],
    );
  }
}
