import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';

class DotBoxButton extends StatelessWidget {
  const DotBoxButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final DotBoxPeaceModel peaceData;
  final Function(DotBoxPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    late double borderWidth;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        image = GeneralIcons.circle3;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.circle3;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected) ||
        peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderWidth = 6;
    } else {
      borderWidth = 2;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            color: AppColors.lightColor,
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
