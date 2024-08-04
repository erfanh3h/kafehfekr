import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/MSweeper/Controllers/msweeper_controller.dart';
import 'package:kafehfekr/Feature/MSweeper/Widgets/msweeper_button.dart';
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
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: GeneralGameConsts.maxGameWidth,
        ),
        padding: AppSpacings.s5All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Obx(
          () => Card(
            child: Padding(
              padding: AppSpacings.s15All,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (ctx, index) => MSweeperButton(
                  peaceData: controller.peaces[index].value,
                  onTap: controller.onEachButtonTap,
                  onHold: controller.onEachButtonHold,
                ),
                itemCount: controller.peaces.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
