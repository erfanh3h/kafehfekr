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
      margin: AppSpacings.s15Horizental,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isBan
              ? [
                  AppColors.darkRed.withValues(alpha: .6),
                  AppColors.transparent,
                  AppColors.darkRed.withValues(alpha: .6),
                ]
              : [
                  AppColors.guideGreen,
                  AppColors.transparent,
                  AppColors.guideGreen,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 5),
          Text(
            isBan ? "حذف اولیه :" : "انتخاب سیستم:",
            style: const TextStyle(color: AppColors.lightColor, fontSize: 20),
          ),
          const SizedBox(width: 5),
          games.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => SizedBox(
                    width: 75,
                    height: 75,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      child: GameButtonWidget(
                        onTap: () {},
                        image: GameTypeConvertor(gameType: games[index])
                            .toGameImage(),
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
                )
              : const SizedBox(
                  width: 75,
                  height: 75,
                  child: Card(
                    color: AppColors.lightColor3,
                    elevation: 3,
                    child: Text(""),
                  ),
                ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
