import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class SudokuSelectNumberButton extends StatelessWidget {
  const SudokuSelectNumberButton({
    super.key,
    required this.number,
    required this.onTap,
    required this.isTapped,
    required this.count,
  });

  final int number;
  final Function(int) onTap;
  final bool isTapped;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          onTap(number);
        },
        child: Container(
          padding: AppSpacings.s5All,
          decoration: BoxDecoration(
            // color: isTapped ? AppColors.green : AppColors.lightColor,
            border: Border.all(
              color: AppColors.darkColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.white38,
                (isTapped ? AppColors.darkGreen : Colors.white)
              ],
              // stops: imageColor != null ? const [0, 0] : null,
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  number.toString(),
                  style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 19,
                      color: isTapped
                          ? AppColors.lightColor
                          : AppColors.darkColor),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  count.toString(),
                  style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 12,
                      color: isTapped
                          ? AppColors.lightColor
                          : AppColors.darkColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
