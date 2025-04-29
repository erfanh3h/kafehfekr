import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';

class GamersDataWidget extends StatelessWidget {
  const GamersDataWidget({
    super.key,
    required this.player1Data,
    required this.player2Data,
    required this.currentTurn,
    required this.systemBannedGames,
  });

  final QueuerModel? player1Data;
  final QueuerModel? player2Data;
  final int currentTurn;
  final List<GameTypes> systemBannedGames;

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
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (player1Data != null)
                  InkWell(
                    onTap: () => FunctionsLibraryClass.showUserData(
                      player1Data!.userId,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        border: Border.all(
                          color: AppColors.lightColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          AvatarIcons().generalAvatarPath(
                            player1Data!.userImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (player1Data != null)
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    clipBehavior: Clip.none,
                    children: [
                      UserRowData(
                        playerData: player1Data!,
                        isPlayerTurn: currentTurn == 1,
                      ),
                    ],
                  ),
                const SizedBox(width: 5),
                if (player2Data != null)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      UserRowData(
                        playerData: player2Data!,
                        isPlayerTurn: currentTurn == 2,
                      ),
                    ],
                  ),
                if (player2Data != null)
                  InkWell(
                    onTap: () => FunctionsLibraryClass.showUserData(
                      player2Data!.userId,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        border: Border.all(
                          color: AppColors.lightColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          AvatarIcons().generalAvatarPath(
                            player2Data!.userImage,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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
    required this.isPlayerTurn,
  });

  final QueuerModel playerData;
  final bool isPlayerTurn;

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = AppColors.lightColor;
    Color fontGroundColor = AppColors.darkColor;
    Color borderColor = isPlayerTurn ? AppColors.darkGreen : AppColors.white;
    double borderSize = isPlayerTurn ? 6 : 2;
    return Container(
      padding: AppSpacings.s5Vertical,
      width: 125,
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [backGroundColor.withValues(alpha: .5), backGroundColor],
        ),
        color: backGroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: borderSize),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FadeIn(
              child: Text(
                playerData.name,
                style: TextStyle(
                  fontFamily: FontFamilies.playPen,
                  fontSize: 13,
                  color: fontGroundColor,
                ),
                textDirection: TextDirection.ltr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    super.key,
    required this.maxTime,
  });

  final int maxTime;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int maxTime = 0;
  late Timer? timer;
  @override
  void initState() {
    setState(() {
      maxTime = widget.maxTime;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (maxTime == 0) {
          timer.cancel();
        } else {
          setState(() {
            maxTime -= 1;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    try {
      timer!.cancel();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: AppColors.lightColor,
      child: Text(
        maxTime.toString(),
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.darkColor,
          fontFamily: FontFamilies.dastnevis,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
