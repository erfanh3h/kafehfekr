import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Models/player_model.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
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
    required this.activePlayerIndexes,
    this.roundText,
    this.currentTurn,
    this.usersNum1,
  });

  final List<Rx<PlayerModel>> playersData;
  final Color? timerColor;
  final String? roundText;
  final int? currentTurn;
  final List<int> activePlayerIndexes;
  final List<int>? usersNum1;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetData = List.generate(
      playersData.length,
      (index) {
        final item = playersData[index];
        int? num1;
        if (usersNum1 != null && index < usersNum1!.length) {
          num1 = usersNum1![index];
        }
        return Obx(
          () => UserRowWidget(
            data: item.value,
            color: playerColors[index],
            isActive: activePlayerIndexes.contains(index + 1),
            num1: num1,
          ),
        );
      },
    );
    widgetData.insert(
      0,
      GlobalShowTimerWidget(
        color: timerColor,
        username: (currentTurn != null && currentTurn! > 0)
            ? playersData[currentTurn! - 1].value.name
            : null,
      ),
    );
    return Container(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      padding: AppSpacings.s10Horizental,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 5),
            if (roundText != null)
              Container(
                margin: AppSpacings.s5Bottom,
                child: GlobalFrameWrapper(
                  padding: AppSpacings.s2All,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '  راند : ',
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
                        "${roundText!}  ",
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
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgetData,
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
    required this.isActive,
    this.num1,
  });

  final PlayerModel data;
  final Color color;
  final bool isActive;
  final int? num1;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : .5,
      child: InkWell(
        onTap: () => FunctionsLibraryClass.showUserData(data.userId),
        child: Container(
          // height: 150,
          constraints: const BoxConstraints(maxWidth: 65),
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
                            color: AppColors.lightColor,
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
              const SizedBox(height: 3),
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
                    fontSize: 12,
                    color: AppColors.lightColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (num1 != null)
                SizedBox(
                  width: 65,
                  child: Text(
                    num1.toString(),
                    style: const TextStyle(
                      fontFamily: FontFamilies.playPen,
                      fontSize: 15,
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
