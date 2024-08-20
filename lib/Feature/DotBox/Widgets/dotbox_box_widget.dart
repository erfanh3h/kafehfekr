import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';

class DotBoxWidget extends StatelessWidget {
  const DotBoxWidget({
    super.key,
    required this.peaceData,
  });

  final DotBoxPeaceModel peaceData;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.imageRedColor;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        break;
      default:
        imageColor = null;
        break;
    }
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        // color: imageColor ?? AppColors.lightColor,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.white54,
            (imageColor ?? Colors.white).withOpacity(.5)
          ],
          stops: imageColor != null ? const [0, 0] : null,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.darkColor,
        ),
      ),
      child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
          ? const GlobalLoadingWidget()
          : Container(),
    );
  }
}
