
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';

class SystemSelectionWidget extends StatelessWidget {
  const SystemSelectionWidget({
    super.key,
    required this.games,
    this.isBan = true,
  });

  final bool isBan;
  final List<GameTypes> games;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: AppSpacings.s10Vertical,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isBan
              ? [
                  AppColors.darkRed,
                  AppColors.darkRed.withValues(alpha: .6),
                ]
              : [
                  AppColors.darkGreen,
                  AppColors.darkGreen.withValues(alpha: .6),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isBan ? Icons.close_outlined : Icons.check,
            color: AppColors.lightColor,
            size: 40,
          ),
          const SizedBox(width: 5),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => SizedBox(
              width: 75,
              height: 75,
              child: FadeIn(
                duration: const Duration(milliseconds: 500),
                child: GameButtonWidget(
                  onTap: () {},
                  image:
                      GameTypeConvertor(gameType: games[index]).toGameImage(),
                  text: games[index].name,
                  imageColor: null,
                  fontSize: 15,
                ),
              ),
            ),
            separatorBuilder: (ctx, index) => const SizedBox(
              width: 5,
            ),
            itemCount: games.length,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
