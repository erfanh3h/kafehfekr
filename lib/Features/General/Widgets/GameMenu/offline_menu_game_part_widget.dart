import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class OfflineMenuGamePartWidget extends StatelessWidget {
  const OfflineMenuGamePartWidget({
    super.key,
    required this.game,
    required this.onTap,
    required this.onOpenGuide,
  });

  final GameTypes game;
  final Function(GameTypes) onTap;
  final Function(GameTypes) onOpenGuide;
  @override
  Widget build(BuildContext context) {
    final gameConvertor = GameTypeConvertor(gameType: game);
    return Container(
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FadeInRight(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: AssetImage(
                    gameConvertor.toGameImage(),
                  ),
                  fit: BoxFit.cover,
                ),
                // border: Border.all(
                //   color: difficultyColor,
                //   width: 2,
                // ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: FadeIn(
              delay: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name.tr,
                    style: TextStyle(
                      fontSize: 18,
                      foreground: Paint()
                        ..strokeWidth = 1.25
                        ..color = AppColors.lightColor
                        ..style = PaintingStyle.stroke,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "تعداد بازیکن: ",
                    style: TextStyle(
                      fontSize: 12,
                      foreground: Paint()..color = AppColors.lightColor2,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              onOpenGuide(game);
            },
            icon: Image.asset(
              GeneralIcons.info,
              width: 35,
              height: 35,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(width: 5),
          FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: IconButton(
              onPressed: () {
                onTap(game);
              },
              icon: const Icon(
                CupertinoIcons.play_circle_fill,
                size: 45,
                color: AppColors.lightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
