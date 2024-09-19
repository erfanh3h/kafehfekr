import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/FekrBekr/Models/fekrbekr_piece_model.dart';

class FekrBekrButton extends StatelessWidget {
  const FekrBekrButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final FekrBekrPeaceModel peaceData;
  final Function(FekrBekrPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected =
        peaceData.currentStatuses.contains(PeaceStatusTypes.selected);
    Color? backgroundColor;
    Color? fontColor;
    // late double borderWidth;
    if (isSelected) {
      backgroundColor = AppColors.darkColor;
      fontColor = AppColors.lightColor;
    } else {
      backgroundColor = AppColors.lightColor;
      fontColor = AppColors.darkColor;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 40,
        height: 40,
        margin: AppSpacings.s10All,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.white24, backgroundColor],
            // stops: imageColor != null ? const [0, 0] : null,
          ),
          // color: AppColors.lightColor,
          border: Border.all(
            color: AppColors.goldenColor,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: peaceData.value != 0
            ? ElasticIn(
                duration: const Duration(milliseconds: 750),
                child: Center(
                  child: Text(
                    peaceData.value.toString(),
                    style: TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 23,
                      color: fontColor,
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
