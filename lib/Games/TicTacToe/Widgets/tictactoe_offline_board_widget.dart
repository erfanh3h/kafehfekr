import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/TicTacToe/Controllers/tictactoe_offline_controller.dart';
import 'package:kafehfekr/Games/TicTacToe/Widgets/tictactoe_button.dart';
import 'package:refreshed/refreshed.dart';

class TicTacToeOfflineBoardWidget extends StatelessWidget {
  const TicTacToeOfflineBoardWidget({
    super.key,
    required this.controller,
  });

  final TicTacToeOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpacings.s30Horizental,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(AppImages.board),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () => Transform.translate(
            offset: Offset(0, -(Get.size.width * .05)),
            child: GridView.builder(
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
