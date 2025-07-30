import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Widgets/tictactoe_button.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToeBoardWidget extends StatelessWidget {
  const TicTacToeBoardWidget({
    super.key,
    required this.controller,
  });

  final TicTacToeController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // padding: AppSpacings.s5All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: GlobalFrameWrapper(
          frame: AppImages.dialog3,
          padding: AppSpacings.s50All,
          child: Obx(
            () => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemBuilder: (ctx, index) => Obx(
                () => TicTacToeButton(
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
  }
}
