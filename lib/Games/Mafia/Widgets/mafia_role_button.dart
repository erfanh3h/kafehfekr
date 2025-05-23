import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class MafiaButton extends StatelessWidget {
  const MafiaButton({
    super.key,
    this.onTap,
    required this.text,
    this.icon = Icons.add,
  });

  final Function(String)? onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(text);
        }
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button4,
        padding: AppSpacings.s5All,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 11,
              ),
            ),
            Icon(
              icon,
              color: AppColors.lightColor,
            ),
          ],
        ),
      ),
    );
  }
}
