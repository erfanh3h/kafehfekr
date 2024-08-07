import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Feature/Othello/Controllers/othello_controller.dart';
import 'package:kafehfekr/Feature/Othello/Widgets/othello_board_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_data_widget.dart';

class OthelloPage extends BaseView<OthelloController> {
  const OthelloPage({super.key});

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
              player1Number2: controller.player1Pawns.value,
              player2Number1: controller.player2Score.value,
              player2Number2: controller.player2Pawns.value,
            ),
          const Spacer(flex: 3),
          OthelloBoarWidget(controller: controller),
          const Spacer(flex: 4),
          GlobalActivityBox(
            surrenderFunction: FunctionsLibraryClass.surrenderFunction,
            reactionFunction: controller.showReactionBox,
            changeShowReactionFunction: controller.changeShowReactionStatus,
            showReaction: controller.showReactions.value,
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
