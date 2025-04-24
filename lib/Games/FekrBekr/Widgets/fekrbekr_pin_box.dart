import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class FekrBekrPinBox extends StatelessWidget {
  const FekrBekrPinBox({
    super.key,
    required this.value,
  });

  final int value;
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    switch (value) {
      case 0:
        backgroundColor = AppColors.transparent;
        break;
      case 1:
        backgroundColor = AppColors.lightColor;
        break;
      case 2:
        backgroundColor = AppColors.darkColor;
        break;
      default:
    }
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.goldenColor,
          width: 2,
        ),
        color: backgroundColor,
      ),
    );
  }
}
