import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:kafehfekr/Feature/RPC/Widgets/rpc_main_widget.dart';

class RPCPage extends BaseView<RPCController> {
  const RPCPage({super.key});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalGameDataWidget(
                  player1Data: controller.players[0].value,
                  player2Data: controller.players[1].value,
                  timerColor: controller.returnTimerColor(),
                  player1Number1: controller.player1RoundScore.value,
                  player2Number1: controller.player2RoundScore.value,
                  player1Number2: controller.player1TotalScore.value,
                  player2Number2: controller.player2TotalScore.value,
                  roundText:
                      "${controller.maxTurnRound} / ${controller.currentTurnRound.value}",
                ),
                Center(
                  child: Text(
                    "${controller.maxRound} / ${controller.currentRound.value}",
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 15,
                      color: Colors.white,
                      height: .6,
                    ),
                  ),
                ),
              ],
            ),
          const Spacer(flex: 3),
          if (controller.isGameStarted.value)
            RPCMainWidget(controller: controller),
          const Spacer(flex: 4),
          GlobalActivityBox<RPCController>(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
