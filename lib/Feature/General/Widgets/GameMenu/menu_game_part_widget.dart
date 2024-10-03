import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class MenuGamePartWidget extends StatelessWidget {
  const MenuGamePartWidget({
    super.key,
    required this.game,
    required this.onTap,
    required this.onOpenGuide,
    required this.isSelected,
    required this.difficultyColor,
  });

  final GameTypes game;
  final Function(GameTypes) onTap;
  final Function(GameTypes) onOpenGuide;
  final bool isSelected;
  final Color difficultyColor;
  @override
  Widget build(BuildContext context) {
    final gameConvertor = GameTypeConvertor(gameType: game);
    return InkWell(
      onTap: () {
        onTap(game);
      },
      child: Container(
        // margin: AppSpacings.s20Vertical,
        padding: AppSpacings.s5All,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInRight(
              delay: const Duration(milliseconds: 200),
              child: Container(
                width: 50,
                height: 50,
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
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: FadeIn(
                delay: const Duration(milliseconds: 300),
                child: Text(
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
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              onPressed: () {
                onOpenGuide(game);
              },
              icon: Image.asset(
                GeneralIcons.info,
                width: 30,
                height: 30,
                color: AppColors.lightColor,
              ),
            ),
            const SizedBox(width: 5),
            FadeInLeft(
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: isSelected,
                  onChanged: null,
                  activeColor: AppColors.lightColor,
                  checkColor: AppColors.lightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                      width: 1.0,
                      color: AppColors.lightColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
