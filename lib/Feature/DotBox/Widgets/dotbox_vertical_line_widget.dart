import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';

class DotBoxVerticalLineWidget extends StatelessWidget {
  const DotBoxVerticalLineWidget({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final DotBoxPeaceModel peaceData;
  final Function(DotBoxPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    Color borderColor = AppColors.darkColor;
    double? borderWidth;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.black;
        borderColor = AppColors.lightColor;
        borderWidth = 1.25;
      case 2:
        imageColor = AppColors.black;
        borderColor = AppColors.lightColor;
        borderWidth = 1.25;
        break;
      default:
        break;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 10,
        height: 45,
        margin: AppSpacings.s2All,
        decoration: BoxDecoration(
          color: imageColor ?? AppColors.lightColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLastTurnPlayed ? AppColors.yellow : borderColor,
            width: isLastTurnPlayed ? 2 : borderWidth ?? 2,
          ),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : Container(),
      ),
    );
  }
}
