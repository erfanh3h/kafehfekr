import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
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
    Color? borderColor;
    String? image;
    if (isThisWinner) {
      borderColor = AppColors.winColor;
    } else {
      borderColor = AppColors.white;
    }
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
    return Container(
      padding: AppSpacings.s15All,
      decoration: BoxDecoration(
        // color: AppColors.lightColor,
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.white24, Colors.white],
        ),
        border: Border.all(
          color: borderColor,
          width: 10,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        image,
        color: imageColor,
      ),
    );
  }
}
