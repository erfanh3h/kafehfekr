import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_controller.dart';
import 'package:kafehfekr/Games/Othello/Widgets/othello_board_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';

class OthelloPage extends BaseView<OthelloController> {
  const OthelloPage({super.key});
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
          GlobalGameDataWidget(
            player1Data: controller.players[0].value,
            player2Data: controller.players[1].value,
            timerColor: controller.returnTimerColor(),
            player1Number1: controller.player1Score.value,
            player1Number2: controller.player1Pawns.value,
            player2Number1: controller.player2Score.value,
            player2Number2: controller.player2Pawns.value,
          ),
        const SizedBox(height: 55),
        Expanded(
          child: ListView(
            children: [
              OthelloBoarWidget(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GlobalActivityBox<OthelloController>(),
        const SizedBox(height: 20),
      ],
    );
  }
}
