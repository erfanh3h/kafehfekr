import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/General/Models/lobby_model.dart';

class LobbyRoomRowWidget extends StatelessWidget {
  const LobbyRoomRowWidget({
    super.key,
    required this.lobby,
  });

  final LobbyModel lobby;
  @override
  Widget build(BuildContext context) {
    Color? color;
    return Container(
      padding: AppSpacings.s10All,
      margin: AppSpacings.s10All,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.lightColor,
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            (color ?? AppColors.transparent).withOpacity(.35),
            color ?? AppColors.transparent
          ],
        ),
      ),
      child: Center(
        child: Text(
          lobby.lobbyName,
          style: const TextStyle(
            color: AppColors.lightColor,
            fontSize: 25,
            fontFamily: FontFamilies.dastnevis,
          ),
        ),
      ),
    );
  }
}
