import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MNumbers/Controllers/mnumbers_offline_controller.dart';
import 'package:kafehfekr/Games/MNumbers/Widgets/mnumbers_offline_button.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersOfflineBoardWidget extends StatelessWidget {
  const MNumbersOfflineBoardWidget({
    super.key,
    required this.controller,
  });

  final MNumbersOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: GlobalFrameWrapper(
          padding: AppSpacings.s30Horizental,
          height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          frame: AppImages.board,
          child: Transform.translate(
            offset: Offset(0, -20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.boardSize.value,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (ctx, index) => Obx(
                () => MNumbersOfflineButton(
                  peaceData: controller.peaces[index].value,
                  onTap: controller.onEachButtonTap,
                ),
              ),
              itemCount: controller.peaces.length,
            ),
          ),
        ),
      );
    });
  }
}
