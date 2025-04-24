import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Games/Othello/Controllers/othello_controller.dart';
import 'package:kafehfekr/Games/Othello/Widgets/othello_button.dart';
import 'package:refreshed/refreshed.dart';

class OthelloBoarWidget extends StatelessWidget {
  const OthelloBoarWidget({
    super.key,
    required this.controller,
  });

  final OthelloController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkColor,
            width: 15,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () => Directionality(
            textDirection: TextDirection.ltr,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (ctx, index) => OthelloButton(
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
