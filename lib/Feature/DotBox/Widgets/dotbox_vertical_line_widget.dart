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
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkColor;
      case 2:
        imageColor = AppColors.darkColor;
        break;
      default:
        imageColor = null;
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
          color: imageColor ?? AppColors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : Container(),
      ),
    );
  }
}
