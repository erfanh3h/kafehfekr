import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Games/MSweeper/Models/msweeper_peace_model.dart';

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
    Color? color;
    bool isSelectedAsBombCorrect = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isCorrectlySelectedAsMine);
    bool isSelectedAsBombWrong = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isWronglySelectedAsMine);
    bool isLoading =
        peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading);
    bool isExplodedMine = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isExplodedMine);
    Color? borderColor = Colors.white54;
    if (isExplodedMine) {
      color = AppColors.imageRedColor;
    }
    if (isSelectedAsBombWrong) {
      color = Colors.amber;
    }
    if (isSelectedAsBombCorrect) {
      color = AppColors.guideGreen;
    }
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
          // color: AppColors.lightColor2,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.white24,
              (color ?? Colors.white).withValues(alpha: .5),
              (color ?? Colors.white)
            ],
            // stops: imageColor != null ? const [0, 0] : null,
          ),
        ),
        child: Center(
          child: isLoading
              ? const GlobalLoadingWidget()
              : Padding(
                  padding: AppSpacings.s10All,
                  child: isExplodedMine
                      ? SpinPerfect(
                          child: Image.asset(
                            GeneralIcons.bombExplode,
                            color: Colors.orangeAccent,
                          ),
                        )
                      : isSelectedAsBombWrong
                          ? Spin(
                              child: Image.asset(
                                GeneralIcons.cross,
                                color: Colors.white70,
                              ),
                            )
                          : isSelectedAsBombCorrect
                              ? ElasticIn(
                                  child: Image.asset(
                                    GeneralIcons.bomb,
                                    color: AppColors.white,
                                  ),
                                )
                              : peaceData.value != null
                                  ? ElasticIn(
                                      child: Text(
                                        peaceData.value.toString(),
                                        style: const TextStyle(
                                          fontFamily: FontFamilies.dastnevis,
                                          fontSize: 22,
                                        ),
                                      ),
                                    )
                                  : Container(),
                ),
        ),
      ),
    );
  }
}
