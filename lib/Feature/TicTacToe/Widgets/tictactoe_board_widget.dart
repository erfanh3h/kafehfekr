import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/TicTacToe/Controllers/tictactoe_controller.dart';
import 'package:kafehfekr/Feature/TicTacToe/Widgets/tictactoe_button.dart';
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
      child: Container(
        padding: AppSpacings.s20All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (ctx, index) => TicTacToeButton(
              peaceData: controller.peaces[index].value,
              onTap: controller.onEachButtonTap,
            ),
            itemCount: controller.peaces.length,
          ),
        ),
      ),
    );
  }
}
