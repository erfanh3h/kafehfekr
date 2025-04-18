import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BoxFour/Models/boxfour_peace_model.dart';

class BoxFourButton extends StatelessWidget {
  const BoxFourButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final BoxFourPeaceModel peaceData;
  final Function(BoxFourPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    double borderSize = 2;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
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
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      borderSize = 5;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          // color: imageColor ?? AppColors.transparent,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white24,
              (imageColor ?? Colors.white70).withValues(alpha: .5)
            ],
            stops: imageColor != null ? const [0, 0] : null,
          ),
          border: Border.all(
            color: isLastTurnPlayed ? AppColors.yellow : AppColors.black,
            width: isLastTurnPlayed ? 4 : borderSize,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : peaceData.value != 0
                ? ElasticIn(
                    duration: const Duration(seconds: 1),
                    child: Center(
                      child: Text(
                        peaceData.value.toString(),
                        style: const TextStyle(
                          color: AppColors.lightColor,
                          fontFamily: FontFamilies.dastnevis,
                          fontSize: 27,
                        ),
                      ),
                    ),
                  )
                : Container(),
      ),
    );
  }
}
