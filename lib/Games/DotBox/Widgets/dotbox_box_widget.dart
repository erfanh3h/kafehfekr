import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Games/DotBox/Models/dotbox_peace_model.dart';

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
        imageColor = AppColors.darkRed;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        break;
      default:
        imageColor = null;
        break;
    }
    return GlobalFrameWrapper(
      padding: EdgeInsets.zero,
      frame: AppImages.button4,
      child: Container(
        width: 40,
        height: 40,
        decoration: imageColor != null
            ? BoxDecoration(
                // color: imageColor ?? AppColors.lightColor,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white54, imageColor.withValues(alpha: .9)],
                  stops: const [0, 0],
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : Container(),
      ),
    );
  }
}
