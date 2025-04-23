import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/enums.dart';
import 'package:kafehfekr/Feature/MSweeper/Models/msweeper_peace_model.dart';

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
    Color? color;
    bool isExplodedMine = peaceData.sweeperStatuses
        .contains(MineSweeperStatusTypes.isExplodedMine);
    bool isEquiped =
        peaceData.currentStatuses.contains(PeaceStatusTypes.equiped);
    bool isSelected =
        peaceData.currentStatuses.contains(PeaceStatusTypes.selected);
    // bool isMine =
    //     peaceData.sweeperStatuses.contains(MineSweeperStatusTypes.isMine);
    Color? borderColor = Colors.white54;
    if (isExplodedMine) {
      color = AppColors.imageRedColor;
    }
    if (isEquiped) {
      color = Colors.amber;
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
          child: isExplodedMine
              ? SpinPerfect(
                  child: Image.asset(
                    GeneralIcons.bombExplode,
                    color: Colors.orangeAccent,
                  ),
                )
              : isEquiped
                  ? ElasticIn(
                      child: Image.asset(
                        GeneralIcons.bomb,
                        color: AppColors.white,
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
