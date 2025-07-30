import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/TicTacToe/Models/tictactoe_peace_model.dart';

class TicTacToeButton extends StatelessWidget {
  const TicTacToeButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final TicTacToePeaceModel peaceData;
  final Function(TicTacToePeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.darkRed;
        image = GeneralIcons.circle1;
        break;
      case 2:
        imageColor = AppColors.imageBlueColor;
        image = GeneralIcons.cross;
        break;
      default:
        imageColor = null;
        image = null;
        break;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        padding: AppSpacings.s15All,
        frame: AppImages.button4,
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? ElasticIn(
                    child: Image.asset(
                      image,
                      color: imageColor,
                    ),
                  )
                : Container(),
      ),
    );
  }
}
