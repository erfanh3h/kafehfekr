import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Chess/Controllers/chess_controller.dart';
import 'package:kafehfekr/Games/Chess/Widgets/chess_button.dart';
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
      child: GlobalFrameWrapper(
        frame: AppImages.board,
        padding: AppSpacings.s25All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
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
                  mustRotate: controller.myGameId == 1,
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
