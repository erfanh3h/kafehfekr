import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Controllers/game_play_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/GameMenu/game_play_users_data_widget.dart';
import 'package:refreshed/refreshed.dart';

class GamePlayPage extends BaseView<GamePlayController> {
  const GamePlayPage({super.key});

  @override
  Widget loadingWidget() {
    return const GlobalLoadingWidget(
      color: AppColors.lightColor,
    );
  }

  @override
  String? backgroundImage() {
    return AppImages.background1;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: Get.size.height,
      width: Get.size.width,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (controller.queuers.length > 1)
              GamePlayUsersDataWidget(
                playersData: controller.queuers.value,
                playerScores: controller.playerScores,
              ),
            if (controller.isGameFinished.value)
              Padding(
                padding: AppSpacings.s20Top,
                child: Center(
                  child: Text(
                    controller.finishGameText.value,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 28,
                      fontFamily: FontFamilies.dastnevis,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            const Spacer(),
            if (controller.gameTypes.isNotEmpty)
              GlobalFrameWrapper(
                frame: AppImages.board,
                padding: AppSpacings.s30All,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      controller.typeToImage(),
                      width: 100,
                      height: 100,
                      color: AppColors.lightColor,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) => Padding(
                          padding: AppSpacings.s10Horizental,
                          child: GamePlayGameRowBox(
                            gameType: controller.gameTypes[index],
                            isActiveGame:
                                controller.currentGameIndex.value == index,
                            isFinished:
                                index < controller.currentGameIndex.value,
                            index: index + 1,
                          ),
                        ),
                        itemCount: controller.gameTypes.length,
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(flex: 2),
            if (controller.isGameFinished.value)
              Container(
                padding: AppSpacings.s10Horizental,
                margin: AppSpacings.s20Bottom,
                child: GlobalButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  text: AppTexts.exit.tr,
                  color: AppColors.buttonRed,
                  height: 60,
                  width: 100,
                ),
              )
            // GlobalActivityBox<FourInRowController>(),
            // const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class GamePlayGameRowBox extends StatelessWidget {
  const GamePlayGameRowBox({
    super.key,
    required this.gameType,
    required this.isActiveGame,
    required this.isFinished,
    required this.index,
  });

  final String gameType;
  final bool isActiveGame;
  final bool isFinished;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.frame4,
      padding: AppSpacings.s10All,
      child: Row(
        children: [
          const SizedBox(width: 5),
          GlobalFrameWrapper(
            frame: AppImages.button2,
            padding: AppSpacings.s2All,
            width: 40,
            height: 40,
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: AppColors.lightColor,
                  fontSize: 30,
                  fontFamily: FontFamilies.dastnevis,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              gameType.tr,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 25,
                fontFamily: FontFamilies.dastnevis,
              ),
            ),
          ),
          GlobalFrameWrapper(
            frame: isFinished ? AppImages.check2 : AppImages.right,
            padding: AppSpacings.s5All,
            child: const SizedBox(
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
