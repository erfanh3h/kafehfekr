import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Ludo/Controllers/ludo_controller.dart';
import 'package:kafehfekr/Games/Ludo/Widgets/ludo_button.dart';
import 'package:kafehfekr/Games/Ludo/Widgets/ludo_user_widget.dart';
import 'package:refreshed/refreshed.dart';

class LudoBoardWidget extends StatelessWidget {
  LudoBoardWidget({
    super.key,
    required this.controller,
  });

  final LudoController controller;

  // top_pos , left_pos , color , piece_index
  final List<(double, double, Color?, int)> piecesData = [
    (0, 130, null, 18),
    (0, 160, null, 19),
    (0, 190, AppColors.blueWarmColor, 20),
    (30, 130, null, 17),
    (30, 160, AppColors.blueWarmColor, 44),
    (30, 190, null, 21),
    (60, 130, null, 16),
    (60, 160, AppColors.blueWarmColor, 45),
    (60, 190, null, 22),
    (90, 130, null, 15),
    (90, 160, AppColors.blueWarmColor, 46),
    (90, 190, null, 23),
    (120, 10, AppColors.yellow, 10),
    (120, 40, null, 11),
    (120, 70, null, 12),
    (120, 100, null, 13),
    (120, 130, null, 14),
    (120, 160, AppColors.blueWarmColor, 47),
    (120, 190, null, 24),
    (120, 220, null, 25),
    (120, 250, null, 26),
    (120, 280, null, 27),
    (120, 310, null, 28),
    (150, 10, null, 9),
    (150, 40, AppColors.yellow, 52),
    (150, 70, AppColors.yellow, 53),
    (150, 100, AppColors.yellow, 54),
    (150, 130, AppColors.yellow, 55),
    // empty
    (150, 190, AppColors.darkGreen, 51),
    (150, 220, AppColors.darkGreen, 50),
    (150, 250, AppColors.darkGreen, 49),
    (150, 280, AppColors.darkGreen, 48),
    (150, 310, null, 29),
    (180, 10, null, 8),
    (180, 40, null, 7),
    (180, 70, null, 6),
    (180, 100, null, 5),
    (180, 130, null, 4),
    (180, 160, AppColors.redWarmColor, 43),
    (180, 190, null, 34),
    (180, 220, null, 33),
    (180, 250, null, 32),
    (180, 280, null, 31),
    (180, 310, AppColors.darkGreen, 30),
    (210, 130, null, 3),
    (210, 160, AppColors.redWarmColor, 42),
    (210, 190, null, 35),
    (240, 130, null, 2),
    (240, 160, AppColors.redWarmColor, 41),
    (240, 190, null, 36),
    (270, 130, null, 1),
    (270, 160, AppColors.redWarmColor, 40),
    (270, 190, null, 37),
    (300, 130, AppColors.redWarmColor, 0),
    (300, 160, null, 39),
    (300, 190, null, 38),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 350,
      // decoration: BoxDecoration(
      //   gradient: const LinearGradient(
      //     begin: Alignment.bottomLeft,
      //     end: Alignment.topRight,
      //     colors: [Colors.transparent, Colors.brown],
      //   ),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      // width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      child: LayoutBuilder(builder: (context, cons) {
        return Container(
          margin: AppSpacings.s10Vertical,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 30,
                  left: 30,
                  child: LudoUserWidget(
                    count: 0,
                    color: AppColors.yellow,
                    onTap: controller.onOutTap,
                    canEquip: false,
                    outCount: 0,
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Obx(
                    () => LudoUserWidget(
                      count: controller.playersOutPieces.value[0],
                      color: AppColors.redWarmColor,
                      onTap: controller.onOutTap,
                      canEquip: controller.currentTurn.value == 1 &&
                          controller.currentAvailableIndexes.value.contains(-1),
                      outCount: controller.playersOutPieces.value[0],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 35,
                  child: LudoUserWidget(
                    count: 0,
                    color: AppColors.darkGreen,
                    onTap: controller.onOutTap,
                    canEquip: false,
                    outCount: 0,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 35,
                  child: Obx(
                    () => LudoUserWidget(
                      count: controller.playersOutPieces.value[1],
                      color: AppColors.blueWarmColor,
                      onTap: controller.onOutTap,
                      canEquip: controller.currentTurn.value == 2 &&
                          controller.currentAvailableIndexes.value.contains(-1),
                      outCount: controller.playersOutPieces.value[1],
                    ),
                  ),
                ),
                for (int i = 0; i < piecesData.length; i++)
                  Positioned(
                    top: piecesData[i].$1,
                    left: piecesData[i].$2,
                    child: Obx(
                      () => LudoButton(
                        pieceData: controller.peaces[piecesData[i].$4].value,
                        onTap: controller.onEachButtonTap,
                        baseColor: piecesData[i].$3,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
