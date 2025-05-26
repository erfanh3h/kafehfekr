import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Features/General/Models/lobby_model.dart';
import 'package:refreshed/refreshed.dart';

class LobbyRoomRowWidget extends StatelessWidget {
  const LobbyRoomRowWidget({
    super.key,
    required this.lobby,
    required this.onJoin,
  });

  final LobbyModel lobby;
  final Function(LobbyModel) onJoin;
  @override
  Widget build(BuildContext context) {
    final gameType = stringToGameType(lobby.gameType);
    final gameConvertor = GameTypeConvertor(gameType: gameType);
    return InkWell(
      onTap: () => onJoin(lobby),
      child: GlobalFrameWrapper(
        // padding: AppSpacings.s10All,
        frame: AppImages.frame4,
        child: Center(
          child: Row(
            children: [
              FadeIn(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: AssetImage(
                        gameConvertor.toGameImage(),
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: AppColors.lightColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lobby.lobbyName,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 22,
                        fontFamily: FontFamilies.playPen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lobby.gameType.tr,
                      style: const TextStyle(
                        color: AppColors.lightColor,
                        fontSize: 14,
                        fontFamily: FontFamilies.dastnevis,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 15),
              Text(
                '${lobby.queuersLength} / ${lobby.lobbyCount} ',
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 20,
                  fontFamily: FontFamilies.dastnevis,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    GlobalGameGuideWidget(gameType: gameType),
                    backgroundColor: AppColors.darkColor,
                  );
                },
                child: const GlobalFrameWrapper(
                  frame: AppImages.info,
                  padding: AppSpacings.s10All,
                  child: SizedBox(
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onJoin(lobby);
                },
                child: const GlobalFrameWrapper(
                  frame: AppImages.play,
                  padding: AppSpacings.s10All,
                  child: SizedBox(
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
