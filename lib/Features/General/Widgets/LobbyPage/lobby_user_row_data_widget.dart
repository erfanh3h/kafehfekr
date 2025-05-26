import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/queuer_model.dart';

class LobbyUserRowData extends StatelessWidget {
  const LobbyUserRowData({
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
    bool isPlayerRdy = playerData != null
        ? (playerData!.isRdy ?? false)
            ? true
            : false
        : false;
    Color nameColor = isPlayerRdy ? AppColors.darkGreen : AppColors.lightColor;
    Color nameFontColor =
        isPlayerRdy ? AppColors.lightColor : AppColors.darkColor;

    return Padding(
      padding: AppSpacings.s5Horizental,
      child: GlobalFrameWrapper(
        padding: AppSpacings.s10All,
        frame: AppImages.frame4,
        width: double.maxFinite,
        height: 140,
        child: Column(
          children: playerData == null
              ? []
              : [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (isMyLobby)
                          GlobalFrameWrapper(
                            frame: AppImages.close,
                            padding: AppSpacings.s5All,
                            width: 50,
                            height: 50,
                            child: InkWell(
                              onTap: () => onKick(playerData!.userId),
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppColors.darkRed,
                              ),
                            ),
                          ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () => FunctionsLibraryClass.showUserData(
                            playerData!.userId,
                          ),
                          child: GlobalFrameWrapper(
                            padding: AppSpacings.s5All,
                            frame: AppImages.button5,
                            width: 55,
                            height: 55,
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
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: nameColor,
                    ),
                    child: Text(
                      playerData!.name,
                      style: TextStyle(
                        fontFamily: FontFamilies.playPen,
                        fontSize: 20,
                        color: nameFontColor,
                      ),
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
        ),
      ),
    );
  }
}
