import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Feature/Pentago/Controllers/pentago_controller.dart';
import 'package:kafehfekr/Feature/Pentago/Widgets/pentago_board_widget.dart';

class PentagoPage extends BaseView<PentagoController> {
  const PentagoPage({super.key});

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
              player1Number1: controller.player1Pawns.value,
              player2Number1: controller.player2Pawns.value,
            ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                PentagoBoardWidget(controller: controller),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlobalActivityBox<PentagoController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
