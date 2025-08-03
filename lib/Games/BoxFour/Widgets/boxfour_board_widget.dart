import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/BoxFour/Controllers/boxfour_controller.dart';
import 'package:kafehfekr/Games/BoxFour/Widgets/boxfour_button.dart';
import 'package:refreshed/refreshed.dart';

class BoxFourBoardWidget extends StatelessWidget {
  const BoxFourBoardWidget({
    super.key,
    required this.controller,
  });

  final BoxFourController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlobalFrameWrapper(
        frame: AppImages.board,
        padding: AppSpacings.s30All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Obx(
          () => Directionality(
            textDirection: TextDirection.ltr,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemBuilder: (ctx, index) => BoxFourButton(
                peaceData: controller.peaces[index].value,
                onTap: controller.onEachButtonTap,
              ),
              itemCount: controller.peaces.length,
            ),
          ),
        ),
      ),
    );
  }
}
