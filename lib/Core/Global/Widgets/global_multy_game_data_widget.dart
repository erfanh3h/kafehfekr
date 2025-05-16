import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_show_timer_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/kori_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class GlobalMultyGameDataWidget extends StatelessWidget {
  const GlobalMultyGameDataWidget({
    super.key,
    required this.playersData,
    required this.timerColor,
    this.roundText,
  });

  final List<Rx<PlayerModel>> playersData;
  final Color? timerColor;
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
            GlobalShowTimerWidget(
              color: timerColor,
              needTimerIcon: false,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                playersData.length,
                (index) {
                  final item = playersData[index];
                  return Obx(
                    () => UserRowWidget(
                      data: item.value,
                      color: playerColors[index],
                    ),
                  );
                },
              ),
            ),
            if (roundText != null)
              Container(
                margin: AppSpacings.s5Top,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'راند : ',
                      style: TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 16,
                        foreground: Paint()
                          ..strokeWidth = 1.5
                          ..color = AppColors.lightColor
                          ..style = PaintingStyle.stroke,
                      ),
                    ),
                    Text(
                      roundText!,
                      style: TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 20,
                        foreground: Paint()
                          ..strokeWidth = 1.5
                          ..color = AppColors.lightColor
                          ..style = PaintingStyle.stroke,
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

class UserRowWidget extends StatelessWidget {
  const UserRowWidget({
    super.key,
    required this.data,
    required this.color,
  });

  final PlayerModel data;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.lightColor2,
      child: InkWell(
        onTap: () => FunctionsLibraryClass.showUserData(data.userId),
        child: Container(
          // height: 150,
          constraints: const BoxConstraints(maxWidth: 75),
          padding: AppSpacings.s5All,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (data.reactionId != null)
                  ? data.reactionId! <= 100
                      ? FadeIn(
                          child: Image.asset(
                            ReactionIcons().generalIconsPath(data.reactionId!),
                            width: 60,
                            height: 60,
                            color: AppColors.darkColor,
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            // color: AppColors.goldenColor2,
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color.fromARGB(200, 212, 133, 126),
                                Color.fromARGB(50, 214, 172, 168),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: KoriBox(
                            isLeft: false,
                            index: data.reactionId! - 101,
                            fontSize: 12,
                            maxLine: 3,
                            fontColor: AppColors.darkColor,
                          ),
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AvatarIcons().generalAvatarPath(
                          data.userImage,
                        ),
                        width: 60,
                        height: 60,
                      ),
                    ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 65,
                child: Text(
                  data.name,
                  style: const TextStyle(
                    fontFamily: FontFamilies.playPen,
                    fontSize: 13,
                    color: AppColors.lightColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
