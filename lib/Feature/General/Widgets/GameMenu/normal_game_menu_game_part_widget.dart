import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_gold_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class NormalGameMenuGamePartWidget extends StatelessWidget {
  const NormalGameMenuGamePartWidget({
    super.key,
    required this.game,
    required this.onTap,
    required this.showButtons,
  });

  final GameTypes game;
  final Function(String, String) onTap;
  final bool showButtons;
  @override
  Widget build(BuildContext context) {
    final gameConvertor = GameTypeConvertor(gameType: game);
    final List<int> gameRewards = gameConvertor.toGameRewards();
    final GameDifficulties difficulty =
        GameTypeConvertor(gameType: game).toGameDifficallty();
    Color difficultyFontColor;
    final Color difficultyColor;
    switch (difficulty) {
      case GameDifficulties.Easy:
        difficultyColor = AppColors.darkGreen;
        difficultyFontColor = AppColors.lightColor;
        break;
      case GameDifficulties.Normal:
        difficultyColor = AppColors.yellow;
        difficultyFontColor = AppColors.darkColor;
        break;
      case GameDifficulties.Hard:
        difficultyColor = AppColors.buttonRed;
        difficultyFontColor = AppColors.lightColor;
        break;
      default:
        difficultyColor = AppColors.green;
        difficultyFontColor = AppColors.lightColor;
    }
    return Container(
      margin: AppSpacings.s20Vertical,
      padding: AppSpacings.s10All,
      // color: Color.fromRGBO(200, index * 10, index * 10, 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            const Color.fromARGB(1, 212, 133, 126),
            difficultyColor.withOpacity(.5),
          ],
        ),
        border: Border.all(
          color: difficultyColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BounceInDown(
            delay: const Duration(milliseconds: 200),
            child: Padding(
              padding: AppSpacings.s20Horizental,
              child: LayoutBuilder(builder: (context, cons) {
                return Container(
                  width: cons.maxWidth,
                  height: cons.maxWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: AssetImage(
                        gameConvertor.toGameImage(),
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: difficultyColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 15),
          ZoomIn(
            delay: const Duration(milliseconds: 300),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    game.name.tr,
                    style: TextStyle(
                      fontSize: 25,
                      foreground: Paint()
                        ..strokeWidth = 1.5
                        ..color = AppColors.lightColor
                        ..style = PaintingStyle.stroke,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  GeneralIcons.cup,
                  width: 30,
                  height: 30,
                  color: AppColors.goldenColor,
                ),
                Text(
                  gameRewards[1].toString(),
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 15),
                Image.asset(
                  GeneralIcons.exp,
                  height: 30,
                  width: 30,
                  color: AppColors.goldenColor,
                ),
                Text(
                  gameRewards[2].toString(),
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: ListView(
                children: [
                  Text(
                    gameConvertor.toGameNarrative(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamilies.dastnevis,
                      color: AppColors.lightColor,
                      height: 1.75,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 25,
                  ),
                ],
              ),
            ),
          ),
          if (showButtons)
            Row(
              children: [
                Expanded(
                  child: FadeInRight(
                    delay: const Duration(milliseconds: 500),
                    child: GlobalButtonWidget(
                      onTap: () {
                        onTap(game.name, "Normal");
                      },
                      text: AppTexts.normalGame.tr,
                      color: AppColors.blueWarmColor,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: FadeInLeft(
                    delay: const Duration(milliseconds: 500),
                    child: GlobalGoldButtonWidget(
                      onTap: () {
                        onTap(game.name, "Rank");
                      },
                      goldCount: gameRewards[0],
                      text: AppTexts.rankGame.tr,
                      fontColor: difficultyFontColor,
                      color: difficultyColor,
                      height: 40.h,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
