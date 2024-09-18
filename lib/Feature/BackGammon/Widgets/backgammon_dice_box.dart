import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class BackGammonDiceBox extends StatelessWidget {
  const BackGammonDiceBox({
    super.key,
    required this.dice,
    required this.onTap,
    required this.isSelected,
    required this.index,
  });

  final int dice;
  final Function(int) onTap;
  final bool isSelected;
  final int index;
  @override
  Widget build(BuildContext context) {
    String diceImage;
    switch (dice) {
      case 1:
        diceImage = GeneralIcons.dice1;
        break;
      case 2:
        diceImage = GeneralIcons.dice2;
        break;
      case 3:
        diceImage = GeneralIcons.dice3;
        break;
      case 4:
        diceImage = GeneralIcons.dice4;
        break;

      case 5:
        diceImage = GeneralIcons.dice5;
        break;
      case 6:
        diceImage = GeneralIcons.dice6;
        break;
      default:
        diceImage = GeneralIcons.dice1;
    }
    return SpinPerfect(
      duration: const Duration(milliseconds: 750),
      child: InkWell(
        onTap: () => onTap(index),
        child: SizedBox(
          width: 40.h,
          height: 40.h,
          child: Card(
            color: isSelected ? AppColors.goldenColor : AppColors.lightColor,
            child: Padding(
              padding: AppSpacings.s5All,
              child: Image.asset(
                diceImage,
                color: !isSelected ? AppColors.darkColor : AppColors.lightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
