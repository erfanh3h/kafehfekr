import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
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
    bool isSelectedAsBombCorrect = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isCorrectlySelectedAsMine);
    bool isSelectedAsBombWrong = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isWronglySelectedAsMine);
    bool isLoading =
        peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading);
    bool isExplodedMine = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isExplodedMine);
    return GestureDetector(
      onTap: () {
        onTap(peaceData);
      },
      onLongPress: () {
        onHold(peaceData);
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button2,
        padding: AppSpacings.s2All,
        child: Center(
          child: isLoading
              ? const GlobalLoadingWidget()
              : Padding(
                  padding: AppSpacings.s5All,
                  child: isExplodedMine
                      ? SpinPerfect(
                          child: Image.asset(
                            GeneralIcons.bombExplode,
                            color: AppColors.darkRed,
                          ),
                        )
                      : isSelectedAsBombWrong
                          ? Spin(
                              child: Image.asset(
                                GeneralIcons.cross,
                                color: AppColors.redWarmColor,
                              ),
                            )
                          : isSelectedAsBombCorrect
                              ? ElasticIn(
                                  child: Image.asset(
                                    GeneralIcons.bomb,
                                    color: AppColors.lightColor,
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
