import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class PentagoSelectionButton extends StatelessWidget {
  const PentagoSelectionButton({
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
      child: Container(
        padding: AppSpacings.s5All,
        margin: AppSpacings.s2All,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.white24, Colors.white],
            // stops: imageColor != null ? const [0, 0] : null,
          ),
          // color: AppColors.lightColor,
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          Icons.arrow_downward_rounded,
          color: Colors.black,
          size: 15.r,
        ),
      ),
    );
  }
}
