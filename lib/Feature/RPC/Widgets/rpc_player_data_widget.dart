import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
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
                playerData: controller.players[0].value,
                playerTotalScore: controller.player1TotalScore.value,
                playerRoundScore: controller.player1RoundScore.value,
                color: AppColors.imageRedColor,
              ),
            ),
            Container(
              margin: AppSpacings.s10Horizental,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GlobalShowTimerWidget(),
                  Card(
                    child: Padding(
                      padding: AppSpacings.s5All,
                      child: Column(
                        children: [
                          Text(
                            "${controller.maxTurnRound} / ${controller.currentTurnRound.value}",
                            style: const TextStyle(
                              fontFamily: FontFamilies.dastnevis,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${controller.maxRound} / ${controller.currentRound.value}",
                            style: const TextStyle(
                              fontFamily: FontFamilies.dastnevis,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: UserRowData(
                  playerData: controller.players[1].value,
                  playerTotalScore: controller.player2TotalScore.value,
                  playerRoundScore: controller.player2RoundScore.value,
                  color: AppColors.imageBlueColor,
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
    required this.playerData,
    required this.playerRoundScore,
    required this.playerTotalScore,
    required this.color,
  });

  final PlayerModel playerData;
  final int playerRoundScore;
  final int playerTotalScore;
  final Color color;

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
          if (playerData.reactionId != null)
            GlobalReactionBox(
              reactionId: playerData.reactionId,
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
                      child: Icon(
                        playerData.isDisconnected
                            ? Icons.desktop_access_disabled
                            : Icons.person_4,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      playerData.name,
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
                      fontSize: 40,
                      color: color,
                    ),
                  ),
                  Text(
                    playerTotalScore.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 17,
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
