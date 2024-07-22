import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_countdown_timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToePlayerDataWidget extends StatelessWidget {
  const TicTacToePlayerDataWidget({
    super.key,
    required this.controller,
  });

  final TicTacToeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: AppSpacings.s10Horizental,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: UserRowData(
                playerName: controller.players[0].value.name,
                playerScore: controller.player1Score.value,
                isThisUserTurn: controller.isThisUserTurn(1),
                color: AppColors.imageRedColor,
              ),
            ),
            Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                "${controller.maxRound} / ${controller.currentRound}",
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: UserRowData(
                  playerName: controller.players[1].value.name,
                  playerScore: controller.player2Score.value,
                  isThisUserTurn: controller.isThisUserTurn(2),
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
    required this.playerName,
    required this.playerScore,
    required this.isThisUserTurn,
    required this.color,
  });

  final String playerName;
  final int playerScore;
  final bool isThisUserTurn;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        color: AppColors.peaceLightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isThisUserTurn ? color : Colors.white,
          width: 3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: color,
                  child: isThisUserTurn
                      ? CountdownTimerWidget(
                          color: color,
                        )
                      : const Icon(
                          Icons.person_2,
                          color: Colors.white,
                        ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  playerName,
                  style: TextStyle(
                    fontFamily: FontFamilies.vazir,
                    fontSize: 15.sp,
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
                fontSize: 30.sp,
                color: color,
              ),
            ),
          ),
          // const Spacer(flex: 3),
        ],
      ),
    );
  }
}
