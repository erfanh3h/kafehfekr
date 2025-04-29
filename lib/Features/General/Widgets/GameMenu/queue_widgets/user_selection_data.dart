import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';

class UserSelectionData extends StatelessWidget {
  const UserSelectionData({
    super.key,
    required this.player1Selection,
    required this.player2Selection,
    this.isBan = true,
  });

  final GameTypes? player1Selection;
  final GameTypes? player2Selection;
  final bool isBan;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s10Vertical,
      margin: AppSpacings.s10Horizental,
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 25),
          // Icon(
          //   isBan ? Icons.close_outlined : Icons.check,
          //   color: AppColors.lightColor,
          //   size: 40,
          // ),
          // const SizedBox(width: 5),
          SizedBox(
            width: 75,
            height: 75,
            child: player1Selection != null
                ? FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: GameButtonWidget(
                      onTap: () {},
                      image: GameTypeConvertor(gameType: player1Selection!)
                          .toGameImage(),
                      text: player1Selection!.name,
                      imageColor: null,
                      fontSize: 15,
                    ),
                  )
                : const Card(
                    color: AppColors.lightColor3,
                    elevation: 3,
                    child: Text(""),
                  ),
          ),
          Expanded(
            child: Center(
              child: Text(
                isBan ? "حذف" : "انتخاب",
                style:
                    const TextStyle(color: AppColors.lightColor, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: 75,
            height: 75,
            child: player2Selection != null
                ? FadeIn(
                    duration: const Duration(milliseconds: 1000),
                    child: GameButtonWidget(
                      onTap: () {},
                      image: GameTypeConvertor(gameType: player2Selection!)
                          .toGameImage(),
                      text: player2Selection!.name,
                      imageColor: null,
                      fontSize: 15,
                    ),
                  )
                : const Card(
                    color: AppColors.lightColor3,
                    elevation: 3,
                    child: Text(""),
                  ),
          ),
          // const SizedBox(width: 5),
          // Icon(
          //   isBan ? Icons.close_outlined : Icons.check,
          //   color: AppColors.lightColor,
          //   size: 40,
          // ),
          const SizedBox(width: 25),
        ],
      ),
    );
  }
}
