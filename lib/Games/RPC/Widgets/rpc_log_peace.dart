import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/RPC/Models/rpc_peace_model.dart';

class RpcLogPeace extends StatelessWidget {
  const RpcLogPeace({
    super.key,
    required this.peaceType,
    required this.imageColor,
    required this.isThisWinner,
  });

  final RPCPeaceTypes peaceType;
  final Color imageColor;
  final bool isThisWinner;

  @override
  Widget build(BuildContext context) {
    String? image;
    switch (peaceType) {
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
    return GlobalFrameWrapper(
      padding: AppSpacings.s20All,
      frame: AppImages.button4,
      child: Image.asset(
        image,
        color: imageColor,
      ),
    );
  }
}
