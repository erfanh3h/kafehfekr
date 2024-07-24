import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/RPC/Models/rpc_peace_model.dart';

class RPCButton extends StatelessWidget {
  const RPCButton({
    super.key,
    required this.peaceData,
    required this.onTap,
  });

  final RPCPeaceModel peaceData;
  final Function(RPCPeaceModel) onTap;

  @override
  Widget build(BuildContext context) {
    Color? imageColor;
    String? image;
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {
      imageColor = AppColors.peaceBorderColor;
    }
    switch (peaceData.peaceType) {
      case RPCPeaceTypes.rock:
        image = GeneralIcons.rock;
        break;
      case RPCPeaceTypes.paper:
        image = GeneralIcons.paper;
        break;
      case RPCPeaceTypes.cutter:
        image = GeneralIcons.cutter;
        break;
      default:
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
          color: AppColors.lightColor,
          border: Border.all(
            color: imageColor ?? AppColors.white,
            width: 4,
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
