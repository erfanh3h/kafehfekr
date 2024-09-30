import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
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
    required this.onGuideTap,
    required this.showButtons,
    required this.difficultyColor,
  });

  final GameTypes game;
  final Function(GameTypes) onTap;
  final Function(GameTypes) onGuideTap;
  final bool showButtons;
  final Color difficultyColor;

  @override
  Widget build(BuildContext context) {
    final gameConvertor = GameTypeConvertor(gameType: game);
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
                IconButton(
                  onPressed: () {
                    onGuideTap(game);
                  },
                  icon: Image.asset(
                    GeneralIcons.info,
                    width: 30,
                    height: 30,
                    color: AppColors.lightColor,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          Expanded(
            child: FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: AppSpacings.s5All,
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
          ),
          if (showButtons)
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: GlobalButtonWidget(
                onTap: () {
                  onTap(game);
                },
                text: AppTexts.startGame.tr,
                color: const Color.fromARGB(255, 12, 63, 32),
                fontColor: AppColors.lightColor,
                width: double.maxFinite,
              ),
            )
        ],
      ),
    );
  }
}
