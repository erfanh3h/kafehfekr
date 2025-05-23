import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_offline_controller.dart';
import 'package:kafehfekr/Games/Othello/Widgets/othello_offline_button.dart';
import 'package:refreshed/refreshed.dart';

class OthelloOfflineBoardWidget extends StatelessWidget {
  const OthelloOfflineBoardWidget({super.key, required this.controller});

  final OthelloOfflineController controller;

  @override
  Widget build(BuildContext context) {
    const int boardSize = 8;
    return GlobalFrameWrapper(
      frame: AppImages.board,
      padding: AppSpacings.s30All,
      height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: boardSize,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: boardSize * boardSize,
        itemBuilder: (context, index) => OthelloOfflineButtonWidget(
          controller: controller,
          index: index,
        ),
      ),
    );
  }
}
