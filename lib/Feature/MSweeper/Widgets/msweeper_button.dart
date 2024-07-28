import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
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
    Color? imageColor = AppColors.goldenColor;
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {}
    return GestureDetector(
      onTap: () {
        onTap(peaceData);
      },
      onLongPress: () {
        onHold(peaceData);
      },
      child: Container(
        padding: AppSpacings.s15All,
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          border: Border.all(color: imageColor, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : peaceData.value != null
                ? Text(peaceData.value.toString())
                : Container(),
      ),
    );
  }
}
