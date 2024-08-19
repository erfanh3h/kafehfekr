import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BackGammon/Controllers/backgammon_controller.dart';
import 'package:kafehfekr/Feature/BackGammon/Widgets/backgammon_button.dart';
import 'package:refreshed/refreshed.dart';

class BackGammonBoardWidget extends StatelessWidget {
  const BackGammonBoardWidget({
    super.key,
    required this.controller,
  });

  final BackGammonController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Container(
          padding: AppSpacings.s5All,
          height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
          child: Card(
            child: Padding(
              padding: AppSpacings.s15All,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) => Obx(
                  () => BackGammonButton(
                    peaceData: controller.peaces[index].value,
                    onTap: controller.onEachButtonTap,
                  ),
                ),
                itemCount: controller.peaces.length,
              ),
            ),
          ),
        ),
      );
    });
  }
}
