import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/MNumbers/Controllers/mnumbers_controller.dart';
import 'package:kafehfekr/Feature/MNumbers/Widgets/MNumbers_button.dart';
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
                  () => MNumbersButton(
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
