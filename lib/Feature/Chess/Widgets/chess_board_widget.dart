import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/Chess/Controllers/chess_controller.dart';
import 'package:kafehfekr/Feature/Chess/Widgets/chess_button.dart';
import 'package:refreshed/refreshed.dart';

class ChessBoardWidget extends StatelessWidget {
  const ChessBoardWidget({
    super.key,
    required this.controller,
  });

  final ChessController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: AppSpacings.s15All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkColor,
            width: 15,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () => Directionality(
            textDirection: TextDirection.ltr,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (ctx, index) => Obx(
                () => ChessButton(
                  peaceData: controller.peaces[index].value,
                  onTap: controller.onEachButtonTap,
                ),
              ),
              itemCount: controller.peaces.length,
            ),
          ),
        ),
      ),
    );
  }
}
