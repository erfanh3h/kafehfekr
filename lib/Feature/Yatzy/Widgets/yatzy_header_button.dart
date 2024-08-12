import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class YatzyHeaderButton extends StatelessWidget {
  const YatzyHeaderButton({
    super.key,
    required this.image,
    required this.onTap,
  });

  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor = AppColors.peaceBorderColor;
    return Expanded(
      child: InkWell(
        onTap: () {
          // onTap(peaceData);
        },
        child: Container(
          // width: 100,
          // height: 100,
          padding: AppSpacings.s5All,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            // border: Border.all(
            //   color: imageColor ?? AppColors.peaceBorderColor,
            //   width: 3,
            // ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            image,
            color: imageColor,
          ),
        ),
      ),
    );
  }
}
