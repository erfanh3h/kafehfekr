import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_controller.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_select_number_button.dart';
import 'package:refreshed/refreshed.dart';

class SudokuSelectNumberBox extends StatelessWidget {
  const SudokuSelectNumberBox({
    super.key,
    required this.controller,
  });

  final SudokuController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
      height: 100,
      child: GlobalFrameWrapper(
        frame: AppImages.board,
        padding: AppSpacings.s15All,
        child: Row(
          children: [
            for (int i = 1; i <= 9; i++)
              GetBuilder<SudokuController>(
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
      ),
    );
  }
}
