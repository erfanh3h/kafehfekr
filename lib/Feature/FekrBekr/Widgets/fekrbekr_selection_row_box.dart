import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
        width: 45,
        height: 45,
        margin: AppSpacings.s10All,
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
                fontSize: 23,
                color: fontColor,
              ),
            ),
          ),
        ));
  }
}
