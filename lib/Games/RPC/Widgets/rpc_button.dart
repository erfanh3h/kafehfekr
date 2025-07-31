import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/RPC/Models/rpc_peace_model.dart';

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
    Color? imageColor = AppColors.lightColor;
    String image;
    if (peaceData.currentStatuses.contains(PeaceStatusTypes.selected)) {
      imageColor = AppColors.darkColor;
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
    }
    return InkWell(
      onTap: () {
        onTap(peaceData);
      },
      child: GlobalFrameWrapper(
        padding: AppSpacings.s20All,
        frame: AppImages.button4,
        child: peaceData.currentStatuses.contains(PeaceStatusTypes.isLoading)
            ? const GlobalLoadingWidget()
            : Image.asset(image, color: imageColor),
      ),
    );
  }
}
