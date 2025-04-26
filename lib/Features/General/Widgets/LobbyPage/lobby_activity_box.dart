import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:refreshed/refreshed.dart';

class LobbyActivityBox extends StatelessWidget {
  const LobbyActivityBox({
    super.key,
    required this.controller,
  });

  final LobbyController controller;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
        maxHeight: 50,
      ),
      child: LayoutBuilder(
        builder: (context, cons) {
          double maxWidth = cons.maxWidth;
          return Obx(
            () => controller.joinedLobby.value != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: maxWidth / 7,
                        child: GlobalActivityButton(
                          icon: GeneralIcons.exit,
                          onTap: controller.exitLobby,
                          text: AppTexts.exit.tr,
                        ),
                      ),
                      SizedBox(
                        width: maxWidth / 7,
                        child: Obx(
                          () => GlobalActivityButton(
                            icon: GeneralIcons.kori,
                            onTap: controller.showChatBox,
                            text: AppTexts.chat.tr,
                            isNotActive:
                                !(controller.letSendChat.value == true),
                          ),
                        ),
                      ),
                      if (controller.isMyLobby())
                        SizedBox(
                          width: maxWidth / 7,
                          child: GlobalActivityButton(
                            icon: GeneralIcons.rank,
                            onTap: controller.startGame,
                            text: AppTexts.start.tr,
                          ),
                        ),
                      SizedBox(
                        width: maxWidth / 7,
                        child: GlobalActivityButton(
                          text: AppTexts.imReady.tr,
                          icon: GeneralIcons.check,
                          onTap: controller.readyStartGame,
                          isNotActive: controller.imReadyToStart.value,
                          needTimerWidget: false,
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
