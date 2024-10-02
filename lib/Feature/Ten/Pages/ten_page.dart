import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Ten/Controllers/ten_controller.dart';
import 'package:kafehfekr/Feature/Ten/Widgets/ten_board_widget.dart';

class TenPage extends BaseView<TenController> {
  const TenPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
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
                roundText:
                    "${controller.maxRound} / ${controller.currentRound}",
              ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  TenBoardWidget(controller: controller),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GlobalActivityBox<TenController>(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
