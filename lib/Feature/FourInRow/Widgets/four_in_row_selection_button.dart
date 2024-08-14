import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
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
      child: Container(
        padding: AppSpacings.s5All,
        margin: AppSpacings.s2All,
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.arrow_downward_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
