import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/kori_box.dart';
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
    this.player1Number1,
    this.player2Number1,
    this.timerValue,
  });

  final int? player1Number1;
  final QueuerModel player1Data;
  final int? player2Number1;
  final QueuerModel player2Data;
  final int? timerValue;

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
                    child: (player1Data.reactionId != null &&
                            player1Data.reactionId! <= 100)
                        ? FadeIn(
                            child: Image.asset(
                              ReactionIcons()
                                  .generalIconsPath(player1Data.reactionId!),
                              width: 20,
                              height: 20,
                            ),
                          )
                        : ClipRRect(
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
                    ),
                    if (player1Data.reactionId != null &&
                        player1Data.reactionId! > 100)
                      Positioned(
                        bottom: -50,
                        left: 30,
                        child: KoriBox(
                          isLeft: false,
                          index: player1Data.reactionId! - 101,
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
                      playerData: player2Data,
                    ),
                    if (player2Data.reactionId != null &&
                        player2Data.reactionId! > 100)
                      Positioned(
                        bottom: -50,
                        right: 30,
                        child: KoriBox(
                          isLeft: true,
                          index: player2Data.reactionId! - 101,
                        ),
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
                    child: (player2Data.reactionId != null &&
                            player2Data.reactionId! <= 100)
                        ? FadeIn(
                            child: Image.asset(
                              ReactionIcons()
                                  .generalIconsPath(player2Data.reactionId!),
                              width: 20,
                              height: 20,
                            ),
                          )
                        : ClipRRect(
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
  });

  final int number;
  final QueuerModel playerData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s5Vertical,
      width: 125,
      height: 65,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.white54, AppColors.lightColor],
        ),
        color: AppColors.lightColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkColor, width: 3),
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
                  style: const TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 35,
                    color: AppColors.darkColor,
                    height: .8,
                  ),
                ),
                Text(
                  playerData.name,
                  style: const TextStyle(
                    fontFamily: FontFamilies.playPen,
                    fontSize: 13,
                    color: AppColors.darkColor,
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
