import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Feature/DotBox/Models/dotbox_peace_model.dart';

class DotBoxHorizentalLineWidget extends StatelessWidget {
  const DotBoxHorizentalLineWidget({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final DotBoxPeaceModel peaceData;
  final Function(DotBoxPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    Color? borderColor;
    double? borderWidth;
    switch (peaceData.selectedUser) {
      case 1:
        imageColor = AppColors.black;
        borderColor = Colors.black;
        borderWidth = 2;
      case 2:
        imageColor = AppColors.black;
        borderColor = Colors.black;
        borderWidth = 2;
        break;
      default:
        break;
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: imageColor ?? AppColors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor ?? Colors.black,
            width: borderWidth ?? 2,
          ),
        ),
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : Container(),
      ),
    );
  }
}
