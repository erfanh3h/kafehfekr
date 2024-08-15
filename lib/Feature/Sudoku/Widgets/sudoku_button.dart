import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/Sudoku/Models/sudoku_peace_model.dart';

class SudokuButton extends StatelessWidget {
  const SudokuButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final SudokuPeaceModel peaceData;
  final Function(SudokuPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        decoration: BoxDecoration(
          color: peaceData.isBaseNumber
              ? AppColors.lightColor2.withOpacity(.75)
              : AppColors.lightColor.withOpacity(.75),
          border: Border.all(
            color: AppColors.darkColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: peaceData.value != 0
              ? Text(
                  peaceData.value.toString(),
                  style: const TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 18,
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
