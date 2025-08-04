import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_multy_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Mill/Controllers/mill_controller.dart';
import 'package:kafehfekr/Games/Mill/Widgets/mill_board_widget.dart';

class MillPage extends BaseView<MillController> {
  const MillPage({super.key});

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
            GlobalMultyGameDataWidget(
              playersData: controller.players.value,
              timerColor: controller.returnTimerColor(),
              activePlayerIndexes: const [1, 2],
              currentTurn: controller.currentTurn.value,
              usersNum1: [
                controller.player2RemovedPeaces.value,
                controller.player1RemovedPeaces.value,
              ],
              usersNum2: [
                controller.player1Peaces.value -
                    controller.player1PlayedPeaces.value,
                controller.player2Peaces.value -
                    controller.player2PlayedPeaces.value,
              ],
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
