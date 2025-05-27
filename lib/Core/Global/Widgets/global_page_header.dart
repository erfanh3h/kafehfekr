import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
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
      spacing: 5,
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: GlobalFrameWrapper(
            frame: AppImages.frame,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.lightColor2,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        backButton,
        const SizedBox(width: 5),
      ],
    );
  }
}
