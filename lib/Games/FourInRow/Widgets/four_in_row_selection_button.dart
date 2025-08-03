import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class FourInRowSelectionButton extends StatelessWidget {
  const FourInRowSelectionButton({
    super.key,
    required this.index,
    required this.onTap,
  });

  final int index;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: const GlobalFrameWrapper(
        padding: AppSpacings.s5All,
        frame: AppImages.button4,
        child: Icon(
          Icons.arrow_downward_rounded,
          color: AppColors.lightColor,
          size: 20,
        ),
      ),
    );
  }
}
