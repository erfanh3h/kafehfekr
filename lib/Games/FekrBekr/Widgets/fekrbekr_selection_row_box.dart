import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class FekrBekrSelectionRowBox extends StatelessWidget {
  const FekrBekrSelectionRowBox({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.lightColor;
    Color fontColor = AppColors.darkColor;
    return Container(
      width: 30.w,
      height: 30.w,
      margin: AppSpacings.s5Horizental10Vertical,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.white24, backgroundColor],
        ),
        border: Border.all(
          color: AppColors.goldenColor,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: ElasticIn(
        duration: const Duration(milliseconds: 750),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
              fontFamily: FontFamilies.dastnevis,
              fontSize: 20,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
