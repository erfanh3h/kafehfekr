import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Sudoku/Controllers/sudoku_controller.dart';
import 'package:kafehfekr/Feature/Sudoku/Widgets/sudoku_button.dart';
import 'package:refreshed/refreshed.dart';

class SudokuBoardPartWidget extends StatelessWidget {
  const SudokuBoardPartWidget({
    super.key,
    required this.controller,
    required this.indexes,
  });

  final SudokuController controller;
  final List<int> indexes;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(1),
      padding: AppSpacings.s5All,
      decoration: BoxDecoration(
        color: AppColors.lightColor2,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(6),
        // gradient: const LinearGradient(
        //   begin: Alignment.bottomLeft,
        //   end: Alignment.topRight,
        //   colors: [Colors.white24, Colors.white54, Colors.white],
        //   // stops: imageColor != null ? const [0, 0] : null,
        // ),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (ctx, index) => Obx(
          () => SudokuButton(
            peaceData: controller.peaces[indexes[index]].value,
            onTap: controller.onEachButtonTap,
          ),
        ),
        itemCount: indexes.length,
      ),
    );
  }
}
