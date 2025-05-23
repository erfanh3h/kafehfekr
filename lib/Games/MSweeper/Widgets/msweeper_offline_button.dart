import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Games/MSweeper/Models/msweeper_peace_model.dart';

class MSweeperOfflineButton extends StatelessWidget {
  const MSweeperOfflineButton({
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
    bool isExplodedMine = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isExplodedMine);
    bool isEquiped =
        peaceData.currentStatuses.contains(PeaceStatusTypes.equiped);
    bool isSelected =
        peaceData.currentStatuses.contains(PeaceStatusTypes.selected);
    // bool isMine =
    //     peaceData.sweeperStatuses.contains(MineSweeperStatusTypes.isMine);
    return GestureDetector(
      onTap: () {
        onTap(peaceData);
      },
      onLongPress: () {
        onHold(peaceData);
      },
      child: GlobalFrameWrapper(
        frame: AppImages.button4,
        padding: AppSpacings.s2All,
        child: Center(
          child: isExplodedMine
              ? SpinPerfect(
                  child: Image.asset(
                    GeneralIcons.bombExplode,
                    color: AppColors.darkRed,
                  ),
                )
              : isEquiped
                  ? ElasticIn(
                      child: Image.asset(
                        GeneralIcons.bomb,
                        color: AppColors.darkColor,
                      ),
                    )
                  : peaceData.value != null && isSelected
                      ? ElasticIn(
                          child: Text(
                            peaceData.value.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: FontFamilies.hekayat,
                            ),
                          ),
                        )
                      : Container(),
        ),
      ),
    );
  }
}
