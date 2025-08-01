import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MNumbers/Controllers/mnumbers_controller.dart';
import 'package:kafehfekr/Games/MNumbers/Widgets/MNumbers_button.dart';
import 'package:refreshed/refreshed.dart';

class MNumbersBoardWidget extends StatelessWidget {
  const MNumbersBoardWidget({
    super.key,
    required this.controller,
  });

  final MNumbersController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: GlobalFrameWrapper(
          padding: AppSpacings.s25All,
          height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          frame: AppImages.board,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (ctx, index) => Obx(
              () => MNumbersButton(
                peaceData: controller.peaces[index].value,
                onTap: controller.onEachButtonTap,
              ),
            ),
            itemCount: controller.peaces.length,
          ),
        ),
      );
    });
  }
}
