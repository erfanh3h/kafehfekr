import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Pentago/Controllers/pentago_controller.dart';
import 'package:kafehfekr/Games/Pentago/Widgets/pentago_piece.dart';
import 'package:refreshed/refreshed.dart';

class PentagoPartWidget extends StatelessWidget {
  const PentagoPartWidget({
    super.key,
    required this.controller,
    required this.indexes,
    required this.partIndex,
  });

  final PentagoController controller;
  final List<int> indexes;
  final int partIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.rotationValues.value[partIndex].value == -1
          ? GlobalFrameWrapper(
              frame: AppImages.board,
              padding: AppSpacings.s10All,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (ctx, index) => Obx(
                  () => PentagoPiece(
                    peaceData: controller.peaces[indexes[index]].value,
                    onTap: controller.onEachButtonTap,
                  ),
                ),
                itemCount: indexes.length,
              ),
            )
          : AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: controller.rotationValues.value[partIndex].value,
              child: GlobalFrameWrapper(
                frame: AppImages.board,
                padding: AppSpacings.s10All,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (ctx, index) => Obx(
                    () => PentagoPiece(
                      peaceData: controller.peaces[indexes[index]].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ),
                  itemCount: indexes.length,
                ),
              ),
            ),
    );
  }
}
