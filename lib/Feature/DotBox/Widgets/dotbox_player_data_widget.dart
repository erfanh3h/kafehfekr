import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/DotBox/Controllers/dotbox_controller.dart';
import 'package:refreshed/refreshed.dart';

class DotBoxPlayerDataWidget extends StatelessWidget {
  const DotBoxPlayerDataWidget({
    super.key,
    required this.controller,
  });

  final DotBoxController controller;

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
                isThisUserTurn: controller.isThisUserTurn(1),
                color: AppColors.imageRedColor,
                playerScore: controller.player1Score.value,
              ),
            ),
            Container(
              padding: AppSpacings.s10Horizental,
              width: 100,
              child: GlobalShowTimerWidget(
                color: controller.returnTimerColor(),
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: UserRowData(
                  playerData: controller.players[1].value,
                  isThisUserTurn: controller.isThisUserTurn(2),
                  color: AppColors.imageBlueColor,
                  playerScore: controller.player2Score.value,
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
    required this.isThisUserTurn,
    required this.color,
    required this.playerScore,
  });

  final bool isThisUserTurn;
  final Color color;
  final PlayerModel playerData;
  final int playerScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s5All,
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isThisUserTurn ? color : Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(height: 3),
                    Text(
                      playerData.name,
                      style: TextStyle(
                        fontFamily: FontFamilies.typo,
                        fontSize: 12,
                        color: color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Text(
                playerScore.toString(),
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 20,
                  color: color,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }
}
