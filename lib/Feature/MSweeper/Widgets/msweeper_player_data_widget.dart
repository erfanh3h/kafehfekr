import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_controller.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperPlayerDataWidget extends StatelessWidget {
  const MSweeperPlayerDataWidget({
    super.key,
    required this.controller,
  });

  final MSweeperController controller;

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
                playerScore: controller.player1Score.value,
                color: AppColors.imageRedColor,
                reactionId: controller.players[0].value.reactionId,
              ),
            ),
            Container(
              padding: AppSpacings.s10Horizental,
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GlobalShowTimerWidget(
                    color: controller.returnTimerColor(),
                  ),
                  Text(
                    controller.selectMineRemainingCount.value.toString(),
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 22,
                      color: AppColors.goldenColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: UserRowData(
                  playerName: controller.players[1].value.name,
                  playerScore: controller.player2Score.value,
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
    required this.playerScore,
    required this.color,
    required this.reactionId,
  });

  final String playerName;
  final int playerScore;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: color,
                      child: const Icon(
                        Icons.person_4,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      playerName,
                      style: TextStyle(
                        fontFamily: FontFamilies.typo,
                        fontSize: 12,
                        color: color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  playerScore.toString(),
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 30,
                    color: color,
                  ),
                ),
              ),
              // const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
