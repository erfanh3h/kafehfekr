import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class OfflineMenuGamePartWidget extends StatelessWidget {
  const OfflineMenuGamePartWidget({
    super.key,
    required this.game,
    required this.onTap,
  });

  final OfflineGameTypes game;
  final Function(OfflineGameTypes) onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(game);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.lightColor3, width: .5),
              ),
              child: Center(
                child: Opacity(
                  opacity: .65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      OfflineGameTypeConvertor.toGameImage(game),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Text(
                game.name.tr,
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontFamily: FontFamilies.dastnevis,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
