import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/BoxFour/Controllers/boxfour_controller.dart';
import 'package:kafehfekr/Games/BoxFour/Widgets/boxfour_board_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';

class BoxFourPage extends BaseView<BoxFourController> {
  const BoxFourPage({super.key});

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
            ),
          const SizedBox(height: 55),
          Expanded(
            child: ListView(
              children: [
                BoxFourBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<BoxFourController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
