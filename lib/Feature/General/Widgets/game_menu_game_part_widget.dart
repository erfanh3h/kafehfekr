import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class GameMenuGamePartWidget extends StatelessWidget {
  const GameMenuGamePartWidget({
    super.key,
    required this.game,
    required this.onTap,
    required this.showButtons,
  });

  final GameTypes game;
  final Function(String) onTap;
  final bool showButtons;
  @override
  Widget build(BuildContext context) {
    final gameConvertor = GameTypeConvertor(gameType: game);
    return Container(
      margin: AppSpacings.s20All,
      padding: AppSpacings.s10All,
      // color: Color.fromRGBO(200, index * 10, index * 10, 1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(1, 212, 133, 126),
            Color.fromARGB(255, 214, 172, 168),
          ],
        ),
        border: Border.all(
          color: AppColors.lightColor,
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
              padding: AppSpacings.s40Horizental,
              child: LayoutBuilder(builder: (context, cons) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    gameConvertor.toGameImage(),
                    width: cons.maxWidth,
                    height: cons.maxWidth,
                    // fit: BoxFit.fill,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 15),
          ZoomIn(
            delay: const Duration(milliseconds: 300),
            child: Text(
              game.name.tr,
              style: TextStyle(
                fontSize: 25,
                foreground: Paint()
                  ..strokeWidth = 1.5
                  ..color = AppColors.lightColor
                  ..style = PaintingStyle.stroke,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Text(
                gameConvertor.toGameNarrative(),
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: FontFamilies.dastnevis,
                  color: AppColors.lightColor,
                  height: 1.75,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
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
                        onTap(game.name);
                      },
                      text: AppTexts.normalGame.tr,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: FadeInLeft(
                    delay: const Duration(milliseconds: 500),
                    child: GlobalButtonWidget(
                      onTap: () {
                        DialogComponent().showToast(label: AppTexts.soon.tr);
                      },
                      text: AppTexts.rankGame.tr,
                      color: Colors.grey,
                      fontColor: AppColors.darkColor,
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
