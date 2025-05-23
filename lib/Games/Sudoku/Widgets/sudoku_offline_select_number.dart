import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_offline_controller.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_select_number_button.dart';
import 'package:refreshed/refreshed.dart';

class SudokuOfflineSelectNumberBox extends StatelessWidget {
  const SudokuOfflineSelectNumberBox({
    super.key,
    required this.controller,
  });

  final SudokuOfflineController controller;
  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.frame4,
      padding: AppSpacings.s20All,
      height: 100,
      child: Row(
        children: [
          for (int i = 1; i <= 9; i++)
            GetBuilder<SudokuOfflineController>(
              builder: (context) => Expanded(
                child: Obx(
                  () => SudokuSelectNumberButton(
                    number: i,
                    onTap: controller.changeSelectedNumber,
                    isTapped: controller.selectedNumber.value == i,
                    count: controller.eachNumbersCount.value[i],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
