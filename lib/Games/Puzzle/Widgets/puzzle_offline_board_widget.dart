import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Puzzle/Controllers/puzzle_offline_controller.dart';
import 'package:kafehfekr/Games/Puzzle/Widgets/puzzle_offline_button.dart';
import 'package:refreshed/refreshed.dart';

class PuzzleOfflineBoardWidget extends StatelessWidget {
  const PuzzleOfflineBoardWidget({super.key, required this.controller});

  final PuzzleOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.board,
      padding: AppSpacings.s30Horizental,
      height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Transform.translate(
          offset: Offset(0, -20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.boardSize,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.boardSize * controller.boardSize,
            itemBuilder: (context, index) => Obx(
              () => PuzzleOfflineButtonWidget(
                data: controller.board[index].value,
                onTap: controller.onButtonTap,
                index: index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
