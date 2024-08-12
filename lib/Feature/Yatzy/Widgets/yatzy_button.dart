import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/Yatzy/Models/yatzy_peace_model.dart';

class YatzyButton extends StatelessWidget {
  const YatzyButton({
    super.key,
    required this.pieceData,
    required this.onTap,
    required this.myGameId,
  });

  final YatzyPeaceModel pieceData;
  final Function(YatzyPeaceModel) onTap;
  final int myGameId;

  @override
  Widget build(BuildContext context) {
    Color? color;
    Color? fontColor = AppColors.lightColor;
    double borderWidth = 0;
    bool canEquip = true;

    if (pieceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      color = AppColors.guideGreen;
      borderWidth = 1;
    } else {
      if (pieceData.isSelected) {
        switch (pieceData.gamerId) {
          case 1:
            color = AppColors.imageRedColor;
            break;
          case 2:
            color = AppColors.imageBlueColor;
            break;
          default:
            color = null;
            break;
        }
      } else {
        color = AppColors.lightColor;
        fontColor = AppColors.darkColor;
      }
    }
    if (myGameId != pieceData.gamerId) {
      canEquip = false;
      fontColor = AppColors.lightColor;
    }

    return canEquip
        ? InkWell(
            onTap: () {
              onTap(pieceData);
            },
            child: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: AppColors.peaceBorderColor,
                  width: borderWidth,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  pieceData.score.toString(),
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 30,
                    height: .7,
                    color: fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : Text(
            pieceData.score.toString(),
            style: TextStyle(
              fontFamily: FontFamilies.dastnevis,
              fontSize: 30,
              height: .7,
              color: fontColor,
            ),
            textAlign: TextAlign.center,
          );
  }
}
