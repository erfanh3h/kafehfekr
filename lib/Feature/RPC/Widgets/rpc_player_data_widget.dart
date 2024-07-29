import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/RPC/Controllers/rpc_controller.dart';
import 'package:refreshed/refreshed.dart';

class RPCPlayerDataWidget extends StatelessWidget {
  const RPCPlayerDataWidget({
    super.key,
    required this.controller,
  });

  final RPCController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: AppSpacings.s10Horizental,
        constraints: const BoxConstraints(
          maxWidth: GeneralGameConsts.maxGameWidth,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: UserRowData(
                playerName: controller.players[0].value.name,
                playerTotalScore: controller.player1TotalScore.value,
                playerRoundScore: controller.player1RoundScore.value,
                color: AppColors.imageRedColor,
                reactionId: controller.players[0].value.reactionId,
              ),
            ),
            Container(
              margin: AppSpacings.s10Horizental,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GlobalShowTimerWidget(),
                  Text(
                    "${controller.maxTurnRound} / ${controller.currentTurnRound.value}",
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: UserRowData(
                  playerName: controller.players[1].value.name,
                  playerTotalScore: controller.player2TotalScore.value,
                  playerRoundScore: controller.player2RoundScore.value,
                  color: AppColors.imageBlueColor,
                  reactionId: controller.players[1].value.reactionId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRowData extends StatelessWidget {
  const UserRowData({
    super.key,
    required this.playerName,
    required this.playerRoundScore,
    required this.playerTotalScore,
    required this.color,
    required this.reactionId,
  });

  final String playerName;
  final int playerRoundScore;
  final int playerTotalScore;
  final Color color;
  final int? reactionId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        color: AppColors.lightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
          width: 3,
        ),
      ),
      child: Stack(
        children: [
          if (reactionId != null)
            GlobalReactionBox(
              reactionId: reactionId,
              color: color,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: color,
                      child: const Icon(
                        Icons.person_2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      playerName,
                      style: const TextStyle(
                        fontFamily: FontFamilies.typo,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    playerRoundScore.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 30,
                      color: color,
                    ),
                  ),
                  Text(
                    playerTotalScore.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 20,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
