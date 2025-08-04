import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Checkers/Models/checkers_peace_model.dart';

class CheckersButton extends StatelessWidget {
  const CheckersButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final CheckersPeaceModel peaceData;
  final Function(CheckersPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    double borderSize = 2;
    double imageScale = 1;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkRed;
        if (peaceData.isSuperPawn) {
          image = GeneralIcons.checkers2;
        } else {
          image = GeneralIcons.checkers1;
        }
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        if (peaceData.isSuperPawn) {
          image = GeneralIcons.checkers2;
        } else {
          image = GeneralIcons.checkers1;
        }
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.equiped)) {
      borderSize = 5;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      if (peaceData.isSuperPawn) {
        image = GeneralIcons.checkers2;
      } else {
        image = GeneralIcons.checkers1;
      }
      imageColor = AppColors.guideGreen;
      imageScale = .33;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button4,
        padding: AppSpacings.s2All,
        child: Container(
          padding: AppSpacings.s5All,
          decoration: BoxDecoration(
            gradient: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 != 0
                ? const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.white38, Colors.white38],
                  )
                : null,
            // color: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 == 0
            //     ? const Color.fromARGB(255, 190, 121, 96)
            //     : AppColors.lightColor,
            border: isLastTurnPlayed
                ? Border.all(
                    color: AppColors.yellow,
                    width: isLastTurnPlayed ? 3 : borderSize,
                  )
                : null,
            borderRadius: BorderRadius.circular(6),
          ),
          child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
              ? const GlobalLoadingWidget()
              : image != null
                  ? Transform.scale(
                      scale: imageScale,
                      child: ElasticIn(
                        duration: const Duration(seconds: 1),
                        child: Image.asset(
                          image,
                          color: imageColor,
                        ),
                      ),
                    )
                  : Container(),
        ),
      ),
    );
  }
}
