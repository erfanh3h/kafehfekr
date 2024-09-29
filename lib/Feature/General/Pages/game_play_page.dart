import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/General/Controllers/game_play_controller.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayPage extends BaseView<GamePlayController> {
  const GamePlayPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.size.height,
      width: Get.size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background2),
          fit: BoxFit.fill,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          // const SizedBox(height: 15),
          // if (controller.players.length > 1)
          //   GlobalGameDataWidget(
          //     player1Data: controller.players[0].value,
          //     player2Data: controller.players[1].value,
          //     timerColor: controller.returnTimerColor(),
          //     player1Number1: controller.player1Pawns.value,
          //     player2Number1: controller.player2Pawns.value,
          //   ),
          // const Spacer(flex: 3),
          // FourInRowBoardWidget(controller: controller),
          // const Spacer(flex: 4),
          // GlobalActivityBox<FourInRowController>(),
          // const Spacer(flex: 1),
        ],
      ),
    );
  }
}
