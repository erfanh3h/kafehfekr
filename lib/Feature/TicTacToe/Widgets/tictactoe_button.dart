import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/status_types.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/TicTacToe/Models/tictactoe_peace_model.dart';

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
        imageColor = AppColors.imageRedColor;
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
      child: Container(
        padding: AppSpacings.s15All,
        decoration: BoxDecoration(
          color: AppColors.peaceLightColor,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : image != null
                ? Image.asset(
                    image,
                    color: imageColor,
                  )
                : Container(),
      ),
    );
  }
}
