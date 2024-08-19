import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Feature/BackGammon/Models/backgammon_piece_model.dart';

class BackGammonButton extends StatelessWidget {
  const BackGammonButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final BackGammonPeaceModel peaceData;
  final Function(BackGammonPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? text;
    late double borderWidth;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        text = peaceData.value.toString();
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        text = peaceData.value.toString();
        break;
      default:
        imageColor = null;
        text = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected) ||
        peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderWidth = 5;
    } else {
      borderWidth = 2;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        // width: 35,
        // height: 35,
        decoration: BoxDecoration(
            color: AppColors.lightColor,
            border: Border.all(
              color: imageColor ?? AppColors.peaceBorderColor,
              width: borderWidth,
            ),
            shape: BoxShape.circle),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : text != null
                ? Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 25,
                      ),
                    ),
                  )
                : Container(),
      ),
    );
  }
}
