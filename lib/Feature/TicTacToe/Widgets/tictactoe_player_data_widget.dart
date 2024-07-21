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
    return Card(
      color: AppColors.topPlayersBoxColor,
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          child: controller.isThisUserTurn(0)
                              ? const CountdownTimerWidget(
                                  color: AppColors.imageRedColor,
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
                          controller.players[0].value.name,
                          style: TextStyle(
                            fontFamily: FontFamilies.vazir,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  Text(
                    controller.player1Score.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 30.sp,
                      color: AppColors.imageRedColor,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
            Padding(
              padding: AppSpacings.s10Horizental,
              child: Text(
                "${controller.maxRound} / ${controller.currentRound}",
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 30.sp,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  Text(
                    controller.player2Score.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 30.sp,
                      color: AppColors.imageBlueColor,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          child: controller.isThisUserTurn(1)
                              ? const CountdownTimerWidget(
                                  color: AppColors.imageBlueColor,
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
                          controller.players[1].value.name,
                          style: TextStyle(
                            fontFamily: FontFamilies.vazir,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
