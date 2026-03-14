import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MSweeper/Controllers/msweeper_offline_controller.dart';
import 'package:kafehfekr/Games/MSweeper/Widgets/msweeper_offline_button.dart';
import 'package:refreshed/refreshed.dart';

class MSweeperOfflineBoardWidget extends StatelessWidget {
  const MSweeperOfflineBoardWidget({
    super.key,
    required this.controller,
  });

  final MSweeperOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlobalFrameWrapper(
        padding: AppSpacings.s30Horizental,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        frame: AppImages.board,
        child: Obx(
          () => Transform.translate(
            offset: Offset(0, -20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.boardSize.value,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemBuilder: (ctx, index) => Obx(
                () => MSweeperOfflineButton(
                  peaceData: controller.peaces[index].value,
                  onTap: controller.onEachButtonTap,
                  onHold: controller.onEachButtonHold,
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
