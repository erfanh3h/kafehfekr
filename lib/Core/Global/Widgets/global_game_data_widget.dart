import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_reaction_box.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalGameDataWidget extends StatelessWidget {
  const GlobalGameDataWidget({
    super.key,
    required this.player1Data,
    required this.player2Data,
    required this.timerColor,
    this.player1Number1,
    this.player1Number2,
    this.player1Number3,
    this.player2Number1,
    this.player2Number2,
    this.player2Number3,
    this.roundText,
  });

  final int? player1Number1;
  final int? player1Number2;
  final int? player1Number3;
  final PlayerModel player1Data;
  final int? player2Number1;
  final int? player2Number2;
  final int? player2Number3;
  final PlayerModel player2Data;
  final Color timerColor;
  final String? roundText;

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
            GlobalShowTimerWidget(color: timerColor),
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
                      top: 7,
                      right: -50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.imageRedColor,
                          border: Border.all(
                            color: AppColors.imageRedColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 50,
                        height: 50,
                        child: player1Data.isDisconnected
                            ? const Icon(
                                Icons.desktop_access_disabled,
                                color: Colors.white,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  AvatarIcons().generalAvatarPath(
                                    Random().nextInt(AvatarIcons.avatarsCount) +
                                        1,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    if (player1Data.isDisconnected)
                      Positioned(
                        bottom: -15,
                        left: 0,
                        child: DisconnectTimerWidget(
                          maxTime: player1Data.disconnectTime,
                          color: AppColors.imageRedColor,
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
                    if (player1Number3 != null)
                      Positioned(
                        top: -15,
                        right: -15,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.imageRedColor,
                          child: Text(
                            player1Number3.toString(),
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
                          reactionId: player1Data.reactionId,
                          color: AppColors.imageRedColor,
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
                      top: 7,
                      left: -50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.imageBlueColor,
                          border: Border.all(
                            color: AppColors.imageBlueColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 50,
                        height: 50,
                        child: player2Data.isDisconnected
                            ? const Icon(
                                Icons.desktop_access_disabled,
                                color: Colors.white,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  AvatarIcons().generalAvatarPath(
                                    Random().nextInt(AvatarIcons.avatarsCount) +
                                        1,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    if (player2Data.isDisconnected)
                      Positioned(
                        bottom: -15,
                        right: 0,
                        child: DisconnectTimerWidget(
                          maxTime: player2Data.disconnectTime,
                          color: AppColors.imageBlueColor,
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
                    if (player2Number3 != null)
                      Positioned(
                        top: -15,
                        left: -15,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.imageBlueColor,
                          child: Text(
                            player2Number3.toString(),
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
            if (roundText != null)
              Container(
                margin: AppSpacings.s5Top,
                child: Text(
                  roundText!,
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 30,
                    foreground: Paint()
                      ..strokeWidth = 1.5
                      ..color = AppColors.lightColor
                      ..style = PaintingStyle.stroke,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DisconnectTimerWidget extends StatefulWidget {
  const DisconnectTimerWidget({
    super.key,
    required this.maxTime,
    required this.color,
  });

  final int maxTime;
  final Color color;

  @override
  State<DisconnectTimerWidget> createState() => _DisconnectTimerWidgetState();
}

class _DisconnectTimerWidgetState extends State<DisconnectTimerWidget> {
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
      backgroundColor: widget.color,
      child: Text(
        maxTime.toString(),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: FontFamilies.dastnevis,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.ltr,
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
        gradient: playerData.isDisconnected
            ? null
            : const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.white24, Colors.white70],
              ),
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
                number != -1 ? number.toString() : '-',
                style: TextStyle(
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 35,
                  color: playerData.isDisconnected
                      ? AppColors.darkColor
                      : AppColors.lightColor,
                  height: .8,
                ),
              ),
              Text(
                playerData.name,
                style: TextStyle(
                  fontFamily: FontFamilies.typo,
                  fontSize: 13,
                  color: playerData.isDisconnected
                      ? AppColors.darkColor
                      : AppColors.lightColor,
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
