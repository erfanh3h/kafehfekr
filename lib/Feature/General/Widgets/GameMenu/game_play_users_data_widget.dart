import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Models/queuer_model.dart';

class GamePlayUsersDataWidget extends StatelessWidget {
  const GamePlayUsersDataWidget({
    super.key,
    required this.player1Data,
    required this.player2Data,
    required this.isGameFinished,
    required this.winnerId,
    this.player1Number1,
    this.player2Number1,
    this.timerValue,
  });

  final int? player1Number1;
  final QueuerModel player1Data;
  final int? player2Number1;
  final QueuerModel player2Data;
  final int? timerValue;
  final bool isGameFinished;
  final int winnerId;

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
            const SizedBox(height: 15),
            timerValue != null
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.lightColor,
                    child: Text(
                      timerValue!.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.darkColor,
                        fontFamily: FontFamilies.dastnevis,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                    ),
                  )
                : const SizedBox(height: 30),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => FunctionsLibraryClass.showUserData(
                    player1Data.userId,
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
                          player1Data.userImage,
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  clipBehavior: Clip.none,
                  children: [
                    UserRowData(
                      number: player1Number1 ?? 0,
                      playerData: player1Data,
                      isGameFinished: isGameFinished,
                      winnerId: winnerId,
                      gamerId: 1,
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserRowData(
                      number: player2Number1 ?? 0,
                      playerData: player2Data,
                      isGameFinished: isGameFinished,
                      winnerId: winnerId,
                      gamerId: 2,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => FunctionsLibraryClass.showUserData(
                    player2Data.userId,
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
                          player2Data.userImage,
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
    required this.number,
    required this.playerData,
    required this.winnerId,
    required this.isGameFinished,
    required this.gamerId,
  });

  final int number;
  final QueuerModel playerData;
  final int winnerId;
  final bool isGameFinished;
  final int gamerId;

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = AppColors.lightColor;
    Color fontGroundColor = AppColors.darkColor;
    if (isGameFinished) {
      if (winnerId == 0) {
        backGroundColor = AppColors.goldenColor;
        fontGroundColor = AppColors.lightColor;
      } else {
        if (gamerId == winnerId) {
          backGroundColor = AppColors.darkGreen;
          fontGroundColor = AppColors.lightColor;
        } else {
          backGroundColor = AppColors.redWarmColor;
          fontGroundColor = AppColors.lightColor;
        }
      }
    }
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
        border: Border.all(color: AppColors.lightColor, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number != -1 ? number.toString() : '-',
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 35,
                    color: fontGroundColor,
                    height: .8,
                  ),
                ),
                Text(
                  playerData.name,
                  style: TextStyle(
                    fontFamily: FontFamilies.playPen,
                    fontSize: 13,
                    color: fontGroundColor,
                  ),
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
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
