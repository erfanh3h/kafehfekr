import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/Mill/Models/mill_peace_model.dart';

class MillButton extends StatelessWidget {
  const MillButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final MillPeaceModel peaceData;
  final Function(MillPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    late double borderWidth;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        image = GeneralIcons.circle2;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.circle2;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected) ||
        peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderWidth = 5;
    } else {
      borderWidth = 1;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.white24, (imageColor ?? Colors.white)],
              // stops: imageColor != null ? const [0, 0] : null,
            ),
            // color: AppColors.lightColor,
            border: Border.all(
              color: imageColor ?? AppColors.peaceBorderColor,
              width: borderWidth,
            ),
            shape: BoxShape.circle),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Image.asset(
                    image,
                    color: imageColor,
                  )
                : Container(),
      ),
    );
  }
}
