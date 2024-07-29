import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/msweeper_peace_model.dart';

class MSweeperButton extends StatelessWidget {
  const MSweeperButton({
    super.key,
    required this.peaceData,
    required this.onTap,
    required this.onHold,
  });

  final MSweeperPeaceModel peaceData;
  final Function(MSweeperPeaceModel) onTap;
  final Function(MSweeperPeaceModel) onHold;

  @override
  Widget build(BuildContext context) {
    bool isSelectedAsBombCorrect = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isCorrectlySelectedAsMine);
    bool isSelectedAsBombWrong = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isWronglySelectedAsMine);
    bool isLoading =
        peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading);
    bool isExplodedMine = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isExplodedMine);
    Color? borderColor = AppColors.goldenColor;
    return GestureDetector(
      onTap: () {
        onTap(peaceData);
      },
      onLongPress: () {
        onHold(peaceData);
      },
      child: Container(
        // padding: AppSpacings.s5All,
        decoration: BoxDecoration(
          color: AppColors.lightColor2,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: isLoading
              ? const GlobalLoadingWidget()
              : isExplodedMine
                  ? Image.asset(
                      GeneralIcons.bombExplode,
                      color: AppColors.buttonRed,
                    )
                  : isSelectedAsBombWrong
                      ? Image.asset(
                          GeneralIcons.cross,
                          color: AppColors.buttonRed,
                        )
                      : isSelectedAsBombCorrect
                          ? Image.asset(
                              GeneralIcons.bomb,
                              color: AppColors.buttonGreen,
                            )
                          : peaceData.value != null
                              ? Text(
                                  peaceData.value.toString(),
                                  style: const TextStyle(
                                    fontFamily: FontFamilies.dastnevis,
                                    fontSize: 20,
                                  ),
                                )
                              : Container(),
        ),
      ),
    );
  }
}
