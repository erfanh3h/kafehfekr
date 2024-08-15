import 'package:flutter/material.dart';
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
    return Card(
      margin: const EdgeInsets.all(1),
      child: Padding(
        padding: AppSpacings.s5All,
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
      ),
    );
  }
}
