import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
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
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: GeneralGameConsts.maxGameWidth,
        ),
        // padding: AppSpacings.s5All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkColor,
            width: 15,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Obx(
          () => GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
