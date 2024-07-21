import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_countdown_timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
      child: Padding(
        padding: AppSpacings.s10Horizental15Vertical,
        child: Obx(
          () => Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
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
                          Text(controller.players[0].value.name),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(controller.player1Score.toString()),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
              Padding(
                padding: AppSpacings.s10Horizental,
                child:
                    Text("${controller.maxRound} / ${controller.currentRound}"),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(flex: 1),
                    Text(controller.player2Score.toString()),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 5,
                      child: Column(
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
                          Text(controller.players[1].value.name),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
