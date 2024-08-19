import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/BackGammon/Models/backgammon_piece_model.dart';

class BackGammonBoardRow extends StatelessWidget {
  const BackGammonBoardRow({
    super.key,
    required this.peaceData,
    required this.onTap,
    this.isRight = true,
  });

  final BackGammonPeaceModel peaceData;
  final Function(BackGammonPeaceModel) onTap;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    late double borderWidth;
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
      borderWidth = 1.5;
    } else {
      borderWidth = .3;
    }
    return LayoutBuilder(builder: (context, cons) {
      double maxWidth = cons.maxWidth;
      double maxHeight = cons.maxHeight;
      return Container(
        margin: AppSpacings.s5Vertical,
        child: InkWell(
          onTap: () {
            onTap(peaceData);
          },
          child: Stack(
            children: [
              peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
                  ? const GlobalLoadingWidget()
                  : peaceData.count != 0
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: isRight
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            for (int i = 0; i < peaceData.count; i++)
                              Container(
                                width: peaceData.count < 5
                                    ? 25
                                    : maxWidth / peaceData.count,
                                height: maxHeight,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: imageColor,
                                ),
                              )
                          ],
                        )
                      : Container(),
              Container(
                height: maxHeight,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.goldenColor, width: borderWidth),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isRight ? 10 : 50),
                    topLeft: Radius.circular(isRight ? 50 : 10),
                    bottomRight: Radius.circular(isRight ? 10 : 50),
                    bottomLeft: Radius.circular(isRight ? 50 : 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
