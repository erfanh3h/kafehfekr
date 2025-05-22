import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';

class GlobalPageHeader extends StatelessWidget {
  const GlobalPageHeader({
    super.key,
    required this.label,
  });

  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: AppSpacings.s20Vertical40Horizental,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.frame2),
              fit: BoxFit.fill,
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.lightColor,
            ),
          ),
        ),
        const Spacer(),
        backButton
      ],
    );
  }
}
