import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Othello/Models/othello_peace_model.dart';

class OthelloButton extends StatelessWidget {
  const OthelloButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final OthelloPeaceModel peaceData;
  final Function(OthelloPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    Color? borderColor;
    String? image;
    double borderSize = 2;
    double imageScale = 1;
    final isLastTurnPlayed =
        peaceData.currentStatuses.contains(PeaceStatusTypes.lastTurnPlayed);
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkRed;
        image = GeneralIcons.checkers1;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.checkers1;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.canSelected)) {
      image = GeneralIcons.checkers1;
      imageColor = AppColors.guideGreen;
      imageScale = .33;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 == 0
                ? [Colors.white24, Colors.white]
                : [Colors.white38, Colors.white38],
          ),
          // color: (peaceData.id % 2 + peaceData.id ~/ 8) % 2 == 0
          //     ? Colors.grey
          //     : AppColors.lightColor,
          border: Border.all(
            color: isLastTurnPlayed
                ? AppColors.yellow
                : borderColor ?? AppColors.black,
            width: isLastTurnPlayed ? 3 : borderSize,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Transform.scale(
                    scale: imageScale,
                    child: ElasticIn(
                      child: Image.asset(
                        image,
                        color: imageColor,
                      ),
                    ),
                  )
                : Container(),
      ),
    );
  }
}
