import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_game_guide_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
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
    final gameType = stringToGameType(
      lobby.gameTypes.first,
    );
    final gameConvertor = GameTypeConvertor(gameType: gameType);

    Color? color;
    return InkWell(
      onTap: () => onJoin(lobby),
      child: Container(
        padding: AppSpacings.s10All,
        margin: AppSpacings.s5All,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: AppColors.lightColor,
          //   width: 2,
          // ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              (color ?? AppColors.darkRed).withValues(alpha: .35),
              color ?? AppColors.darkRed
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent.withValues(alpha: .35),
              blurRadius: 5,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
        ),
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
                      lobby.gameTypes.first.tr,
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
              // Text(
              //   '${lobby.queuersLength} / 2',
              //   style: const TextStyle(
              //     color: AppColors.lightColor,
              //     fontSize: 20,
              //     fontFamily: FontFamilies.dastnevis,
              //   ),
              //   textDirection: TextDirection.ltr,
              // ),
              const SizedBox(width: 5),
              FadeIn(
                child: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      GlobalGameGuideWidget(gameType: gameType),
                      backgroundColor: AppColors.darkColor,
                    );
                  },
                  icon: Image.asset(
                    GeneralIcons.info,
                    color: AppColors.lightColor,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              FadeIn(
                child: IconButton(
                  onPressed: () {
                    onJoin(lobby);
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.lightColor,
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
