import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Mill/Controllers/mill_controller.dart';
import 'package:kafehfekr/Feature/Mill/Widgets/mill_board_widget.dart';

class MillPage extends BaseView<MillController> {
  const MillPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
              player1Number1: controller.player2RemovedPeaces.value,
              player2Number1: controller.player1RemovedPeaces.value,
              player1Number2: controller.player1Peaces.value -
                  controller.player1PlayedPeaces.value,
              player2Number2: controller.player2Peaces.value -
                  controller.player2PlayedPeaces.value,
              player1Number3: controller.players[0].value.notPlayedTurns,
              player2Number3: controller.players[1].value.notPlayedTurns,
            ),
          const SizedBox(height: 55),
          MillBoardWidget(controller: controller),
          const Spacer(),
          GlobalActivityBox<MillController>(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
