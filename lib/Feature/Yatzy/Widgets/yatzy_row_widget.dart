import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yatzy/Controllers/yatzy_controller.dart';
import 'package:kafehfekr/Feature/Yatzy/Widgets/yatzy_button.dart';
import 'package:refreshed/refreshed.dart';

class YatzyRowWidget extends StatelessWidget {
  const YatzyRowWidget({
    super.key,
    required this.headerImage,
    required this.index,
    required this.controller,
  });

  final String headerImage;
  final int index;
  final YatzyController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onEachRowTap(index);
      },
      child: Container(
        margin: AppSpacings.s3Vertical,
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index % 2 == 0 ? Colors.white12 : Colors.white24,
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () => YatzyButton(
                  pieceData: controller.player2Pieces.value[index].value,
                  onTap: controller.onEachButtonTap,
                  myGameId: controller.myGameId,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Obx(
                () => YatzyButton(
                  pieceData: controller.player1Pieces.value[index].value,
                  onTap: controller.onEachButtonTap,
                  myGameId: controller.myGameId,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Container(
                padding: AppSpacings.s5All,
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.white24, Colors.white70],
                  ),
                ),
                child: Image.asset(
                  headerImage,
                  color: AppColors.darkColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
