import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Games/MNumbers/Models/mnumbers_peace_model.dart';

class MNumbersOfflineButton extends StatelessWidget {
  const MNumbersOfflineButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final MNumbersPeaceModel peaceData;
  final Function(MNumbersPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? text;
    late double borderWidth;

    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {
      imageColor = AppColors.darkGreen;
      text = peaceData.value.toString();
      borderWidth = 5;
    } else if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      imageColor = AppColors.goldenColor;
      text = peaceData.value.toString();
      borderWidth = 5;
    } else {
      text = null;
      borderWidth = 1;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        // width: 35,
        // height: 35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.white24, (imageColor ?? Colors.white)],
          ),
          // color: AppColors.lightColor,
          border: Border.all(
            color: imageColor ?? AppColors.peaceBorderColor,
            width: borderWidth,
          ),
          shape: BoxShape.circle,
        ),
        child: text != null
            ? ElasticIn(
                duration: const Duration(milliseconds: 750),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 25,
                      color: AppColors.lightColor,
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
