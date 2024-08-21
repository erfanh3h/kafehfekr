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
    bool canEquip = true;
    int value = 0;
    if (pieceData.isSelected) {
      canEquip = false;
      switch (pieceData.gamerId) {
        case 1:
          color = AppColors.imageRedColor;
          value = pieceData.score;
          break;
        case 2:
          color = AppColors.imageBlueColor;
          value = pieceData.score;
          break;
        default:
          color = null;
          break;
      }
    } else {
      if (myGameId != pieceData.gamerId) {
        canEquip = false;
        fontColor = AppColors.lightColor;
        color = Colors.transparent;
      } else {
        value = pieceData.calculatedScore;
        if (pieceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
          color = AppColors.guideGreen;
        } else {
          color = AppColors.lightColor;
          fontColor = AppColors.darkColor;
        }
      }
    }

    return InkWell(
      onTap: () {
        if (canEquip) {
          onTap(pieceData);
        }
      },
      child: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white24,
              (color ?? Colors.white).withOpacity(.25),
              (color ?? Colors.white).withOpacity(.75),
              (color ?? Colors.white)
            ],
          ),
        ),
        child: Center(
          child: Text(
            value.toString(),
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
    );
  }
}
