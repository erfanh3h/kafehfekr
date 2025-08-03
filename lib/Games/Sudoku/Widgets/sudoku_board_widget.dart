import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/Sudoku/Controllers/sudoku_controller.dart';
import 'package:kafehfekr/Games/Sudoku/Widgets/sudoku_board_part_widget.dart';
import 'package:refreshed/refreshed.dart';

final List<List<int>> indexes = [
  [0, 1, 2, 9, 10, 11, 18, 19, 20],
  [3, 4, 5, 12, 13, 14, 21, 22, 23],
  [6, 7, 8, 15, 16, 17, 24, 25, 26],
  [27, 28, 29, 36, 37, 38, 45, 46, 47],
  [30, 31, 32, 39, 40, 41, 48, 49, 50],
  [33, 34, 35, 42, 43, 44, 51, 52, 53],
  [54, 55, 56, 63, 64, 65, 72, 73, 74],
  [57, 58, 59, 66, 67, 68, 75, 76, 77],
  [60, 61, 62, 69, 70, 71, 78, 79, 80],
];

class SudokuBoardWidget extends StatelessWidget {
  const SudokuBoardWidget({
    super.key,
    required this.controller,
  });

  final SudokuController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlobalFrameWrapper(
        frame: AppImages.board,
        // padding: AppSpacings.s10All,
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[0],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[1],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[2],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[3],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[4],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[5],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[6],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[7],
                      ),
                    ),
                    Expanded(
                      child: SudokuBoardPartWidget(
                        controller: controller,
                        indexes: indexes[8],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
