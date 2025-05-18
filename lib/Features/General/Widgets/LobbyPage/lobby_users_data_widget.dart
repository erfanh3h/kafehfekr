import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';
import 'package:refreshed/refreshed.dart';

class LobbyUsersDataWidget extends StatelessWidget {
  const LobbyUsersDataWidget({
    super.key,
    required this.playersData,
    required this.isMyLobby,
    required this.onKick,
    required this.lobbyCount,
  });

  final List<Rx<QueuerModel>> playersData;
  final bool isMyLobby;
  final Function(String) onKick;
  final int lobbyCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      padding: AppSpacings.s10Horizental,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            lobbyCount,
            (index) {
              Rx<QueuerModel?> item = Rx(null);
              if (index < playersData.length) {
                item = playersData[index];
              }
              return Obx(
                () => UserRowData(
                  playerData: item.value,
                  onKick: onKick,
                  isMyLobby: isMyLobby,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserRowData extends StatelessWidget {
  const UserRowData({
    super.key,
    required this.playerData,
    required this.onKick,
    required this.isMyLobby,
  });

  final QueuerModel? playerData;
  final Function(String) onKick;
  final bool isMyLobby;

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = AppColors.lightColor;
    Color fontGroundColor = AppColors.darkColor;
    Color borderColor = playerData != null
        ? (playerData!.isRdy ?? false)
            ? AppColors.darkGreen
            : AppColors.white
        : AppColors.white;
    return Container(
      padding: AppSpacings.s5All,
      margin: AppSpacings.s10Horizental,
      width: 70,
      height: isMyLobby ? 140 : 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [backGroundColor.withValues(alpha: .5), backGroundColor],
        ),
        color: backGroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: playerData == null
            ? []
            : [
                InkWell(
                  onTap: () => FunctionsLibraryClass.showUserData(
                    playerData!.userId,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightColor,
                      border: Border.all(
                        color: AppColors.lightColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        AvatarIcons().generalAvatarPath(
                          playerData!.userImage,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  playerData!.name,
                  style: TextStyle(
                    fontFamily: FontFamilies.playPen,
                    fontSize: 13,
                    color: fontGroundColor,
                  ),
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                if (isMyLobby)
                  IconButton(
                    color: AppColors.redWarmColor,
                    onPressed: () => onKick(playerData!.userId),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.darkRed,
                    ),
                  ),
              ],
      ),
    );
  }
}
