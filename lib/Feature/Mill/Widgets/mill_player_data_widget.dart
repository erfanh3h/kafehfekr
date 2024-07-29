import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Mill/Controllers/mill_controller.dart';
import 'package:refreshed/refreshed.dart';

class MillPlayerDataWidget extends StatelessWidget {
  const MillPlayerDataWidget({
    super.key,
    required this.controller,
  });

  final MillController controller;

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
                isThisUserTurn: controller.isThisUserTurn(1),
                color: AppColors.imageRedColor,
                reactionId: controller.players[0].value.reactionId,
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
                  playerName: controller.players[1].value.name,
                  isThisUserTurn: controller.isThisUserTurn(2),
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
    required this.isThisUserTurn,
    required this.color,
    required this.reactionId,
  });

  final String playerName;
  final bool isThisUserTurn;
  final Color color;
  final int? reactionId;

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
                flex: 1,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: color,
                  child: const Icon(
                    Icons.person_4,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  playerName,
                  style: TextStyle(
                    fontFamily: FontFamilies.typo,
                    fontSize: 12,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
