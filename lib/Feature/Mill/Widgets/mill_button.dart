import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
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
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        image = GeneralIcons.circle1;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.cross;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s15All,
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          border: Border.all(
            color: imageColor ?? AppColors.peaceBorderColor,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
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
