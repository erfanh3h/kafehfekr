import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
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
    bool canEquip = true;
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
    if (myGameId != pieceData.gamerId) {
      canEquip = false;
    }
    if (pieceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      color = AppColors.guideGreen;
    }
    return Expanded(
      child: canEquip
          ? InkWell(
              onTap: () {
                onTap(pieceData);
              },
              child: Container(
                width: double.maxFinite,
                // padding: AppSpacings.s15All,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: AppColors.peaceBorderColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pieceData.score.toString(),
                  style: const TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Text(
              pieceData.score.toString(),
              style: const TextStyle(
                fontFamily: FontFamilies.dastnevis,
                fontSize: 40,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
