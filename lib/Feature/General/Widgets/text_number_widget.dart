import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class TextNumberWidget extends StatelessWidget {
  const TextNumberWidget({
    super.key,
    required this.text,
    required this.number,
  });

  final String text;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s10All,
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.lightColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.lightColor,
              fontFamily: FontFamilies.dastnevis,
            ),
          ),
        ],
      ),
    );
  }
}
