import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
          decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: [Colors.transparent, AppColors.white],
            //   // stops: imageColor != null ? const [0, 0] : null,
            // ),
            border: Border.all(
              color: AppColors.darkColor,
              width: 15,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
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
