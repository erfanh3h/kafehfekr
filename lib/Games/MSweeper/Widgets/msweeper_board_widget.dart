import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MSweeper/Controllers/msweeper_controller.dart';
import 'package:kafehfekr/Games/MSweeper/Widgets/msweeper_button.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperBoardWidget extends StatelessWidget {
  const MSweeperBoardWidget({
    super.key,
    required this.controller,
  });

  final MSweeperController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlobalFrameWrapper(
        padding: AppSpacings.s30All,
        frame: AppImages.board,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemBuilder: (ctx, index) => Obx(
              () => MSweeperButton(
                peaceData: controller.peaces[index].value,
                onTap: controller.onEachButtonTap,
                onHold: controller.onEachButtonHold,
              ),
            ),
            itemCount: controller.peaces.length,
          ),
        ),
      ),
    );
  }
}
