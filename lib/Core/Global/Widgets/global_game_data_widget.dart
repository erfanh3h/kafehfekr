import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalGameDataWidget extends StatelessWidget {
  const GlobalGameDataWidget({
    super.key,
    required this.player1Data,
    required this.player2Data,
    required this.timerColor,
    this.player1Number1,
    this.player1Number2,
    this.player2Number1,
    this.player2Number2,
  });

  final int? player1Number1;
  final int? player1Number2;
  final PlayerModel player1Data;
  final int? player2Number1;
  final int? player2Number2;
  final PlayerModel player2Data;
  final Color timerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      padding: AppSpacings.s10Horizental,
      child: Center(
        child: Column(
          children: [
            Container(
              padding: AppSpacings.s10Horizental,
              width: 100,
              child: GlobalShowTimerWidget(color: timerColor),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  clipBehavior: Clip.none,
                  children: [
                    UserRowData(
                      number: player1Number1 ?? 0,
                      color: AppColors.imageRedColor,
                      playerData: player1Data,
                    ),
                    Positioned(
                      top: -20,
                      right: -20,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.imageRedColor,
                        child: Icon(
                          player1Data.isDisconnected
                              ? Icons.desktop_access_disabled
                              : Icons.person_4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (player1Number2 != null)
                      Positioned(
                        bottom: -15,
                        right: -15,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.imageRedColor,
                          child: Text(
                            player1Number2.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamilies.dastnevis,
                            ),
                          ),
                        ),
                      ),
                    if (player1Data.reactionId != null)
                      Positioned(
                        bottom: -35,
                        left: 40,
                        child: GlobalReactionBox(
                          reactionId: player2Data.reactionId,
                          color: AppColors.imageBlueColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 5),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserRowData(
                      number: player2Number1 ?? 0,
                      color: AppColors.imageBlueColor,
                      playerData: player2Data,
                    ),
                    Positioned(
                      top: -20,
                      left: -20,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.imageBlueColor,
                        child: Icon(
                          player2Data.isDisconnected
                              ? Icons.desktop_access_disabled
                              : Icons.person_4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (player2Number2 != null)
                      Positioned(
                        bottom: -15,
                        left: -15,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.imageBlueColor,
                          child: Text(
                            player2Number2.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamilies.dastnevis,
                            ),
                          ),
                        ),
                      ),
                    if (player2Data.reactionId != null)
                      Positioned(
                        bottom: -35,
                        left: 40,
                        child: GlobalReactionBox(
                          reactionId: player2Data.reactionId,
                          color: AppColors.imageBlueColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Container(
              margin: AppSpacings.s5Top,
              child: const Text(
                "1 / 1",
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 30,
                  color: Colors.white,
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
    required this.number,
    required this.color,
    required this.playerData,
  });

  final int number;
  final Color color;
  final PlayerModel playerData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s5Vertical,
      width: 125,
      decoration: BoxDecoration(
        color: playerData.isDisconnected
            ? AppColors.dcColor
            : AppColors.lightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
          width: 3,
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.toString(),
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 35,
                  color: color,
                  height: .8,
                ),
              ),
              Text(
                playerData.name,
                style: TextStyle(
                  fontFamily: FontFamilies.typo,
                  fontSize: 13,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
