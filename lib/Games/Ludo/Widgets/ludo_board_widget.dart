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

  final List<(double, double, Color?)> positions = [
    (0, 130, null),
    (0, 160, null),
    (0, 190, AppColors.blueWarmColor),
    (30, 130, null),
    (30, 160, AppColors.blueWarmColor),
    (30, 190, null),
    (60, 130, null),
    (60, 160, AppColors.blueWarmColor),
    (60, 190, null),
    (90, 130, null),
    (90, 160, AppColors.blueWarmColor),
    (90, 190, null),
    (120, 10, AppColors.yellow),
    (120, 40, null),
    (120, 70, null),
    (120, 100, null),
    (120, 130, null),
    (120, 160, AppColors.blueWarmColor),
    (120, 190, null),
    (120, 220, null),
    (120, 250, null),
    (120, 280, null),
    (120, 310, null),
    (120, 130, null),
    (120, 160, AppColors.blueWarmColor),
    (120, 190, null),
    (150, 10, null),
    (150, 40, AppColors.yellow),
    (150, 70, AppColors.yellow),
    (150, 100, AppColors.yellow),
    (150, 130, AppColors.yellow),
    // empty
    (150, 190, AppColors.darkGreen),
    (150, 220, AppColors.darkGreen),
    (150, 250, AppColors.darkGreen),
    (150, 280, AppColors.darkGreen),
    (150, 310, null),
    (180, 10, null),
    (180, 40, null),
    (180, 70, null),
    (180, 100, null),
    (180, 130, null),
    (180, 160, AppColors.redWarmColor),
    (180, 190, null),
    (180, 220, null),
    (180, 250, null),
    (180, 280, null),
    (180, 310, AppColors.darkGreen),
    (210, 130, null),
    (210, 160, AppColors.redWarmColor),
    (210, 190, null),
    (240, 130, null),
    (240, 160, AppColors.redWarmColor),
    (240, 190, null),
    (270, 130, null),
    (270, 160, AppColors.redWarmColor),
    (270, 190, null),
    (300, 130, AppColors.redWarmColor),
    (300, 160, null),
    (300, 190, null),
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
                const Positioned(
                  top: 30,
                  left: 30,
                  child: LudoUserWidget(count: 0, color: AppColors.yellow),
                ),
                const Positioned(
                  bottom: 30,
                  left: 30,
                  child:
                      LudoUserWidget(count: 0, color: AppColors.redWarmColor),
                ),
                const Positioned(
                  bottom: 30,
                  right: 35,
                  child: LudoUserWidget(count: 0, color: AppColors.darkGreen),
                ),
                const Positioned(
                  top: 30,
                  right: 35,
                  child:
                      LudoUserWidget(count: 0, color: AppColors.blueWarmColor),
                ),
                for (int i = 0; i < positions.length; i++)
                  Positioned(
                    top: positions[i].$1,
                    left: positions[i].$2,
                    child: Obx(
                      () => LudoButton(
                        pieceData: controller.peaces[i].value,
                        onTap: controller.onEachButtonTap,
                        color: positions[i].$3,
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
