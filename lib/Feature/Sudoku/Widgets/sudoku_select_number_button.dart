import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';

class SudokuSelectNumberButton extends StatelessWidget {
  const SudokuSelectNumberButton({
    super.key,
    required this.number,
    required this.onTap,
    required this.isTapped,
  });

  final int number;
  final Function(int) onTap;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(number);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isTapped ? AppColors.green : AppColors.lightColor,
          border: Border.all(
            color: AppColors.darkColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontFamily: FontFamilies.dastnevis,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
