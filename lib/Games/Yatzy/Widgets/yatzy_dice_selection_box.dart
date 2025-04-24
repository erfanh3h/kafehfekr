import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class DiceSelectionBox extends StatelessWidget {
  const DiceSelectionBox({
    super.key,
    required this.value,
    required this.onSelect,
    required this.index,
    required this.isSelected,
  });

  final int value;
  final Function(int) onSelect;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    String? image;
    switch (value) {
      case 1:
        image = GeneralIcons.dice1;
        break;
      case 2:
        image = GeneralIcons.dice2;
        break;
      case 3:
        image = GeneralIcons.dice3;
        break;
      case 4:
        image = GeneralIcons.dice4;
        break;
      case 5:
        image = GeneralIcons.dice5;
        break;
      case 6:
        image = GeneralIcons.dice6;
        break;
      default:
        image = null;
    }
    return SpinPerfect(
      child: InkWell(
        onTap: () => onSelect(index),
        child: Container(
          margin: AppSpacings.s2All,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Colors.white.withOpacity(isSelected ? .75 : 0.25),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.white24,
                (isSelected ? AppColors.green : Colors.white54)
              ],
              // stops: imageColor != null ? const [0, 0] : null,
            ),
          ),
          child: Center(
              child: image != null
                  ? Image.asset(
                      image,
                      color: isSelected
                          ? AppColors.darkColor
                          : AppColors.lightColor,
                    )
                  : Container()),
        ),
      ),
    );
  }
}
