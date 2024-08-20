import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/BoxFour/Controllers/boxfour_controller.dart';
import 'package:kafehfekr/Feature/BoxFour/Widgets/boxfour_button.dart';
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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkColor,
            width: 15,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
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
