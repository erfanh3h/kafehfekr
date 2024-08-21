import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:refreshed/refreshed.dart';

class GlobalActivityBox<T extends BaseGameController> extends StatelessWidget {
  GlobalActivityBox({
    super.key,
  });

  final T controller = Get.find<T>();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      child: LayoutBuilder(builder: (context, cons) {
        double maxWidth = cons.maxWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth / 7,
              child: const GlobalActivityButton(
                icon: GeneralIcons.death,
                onTap: FunctionsLibraryClass.surrenderFunction,
                color: AppColors.buttonRed,
              ),
            ),
            SizedBox(
              width: maxWidth / 7,
              child: Obx(
                () => GlobalActivityButton(
                  icon: controller.showReactions.value
                      ? GeneralIcons.enableReaction
                      : GeneralIcons.disableReaction,
                  onTap: controller.changeShowReactionStatus,
                  color: controller.showReactions.value
                      ? AppColors.green
                      : AppColors.redWarmColor,
                ),
              ),
            ),
            SizedBox(
              width: maxWidth / 7,
              child: GlobalActivityButton(
                icon: ReactionIcons().generalIconsPath(5),
                onTap: controller.showReactionBox,
                color: AppColors.goldenColor,
              ),
            ),
            SizedBox(
              width: maxWidth / 7,
              child: Obx(
                () => GlobalActivityButton(
                  icon: controller.letPlaySound.value
                      ? GeneralIcons.soundOn
                      : GeneralIcons.soundOff,
                  onTap: controller.changeLetPlaySound,
                  color: controller.letPlaySound.value
                      ? AppColors.green
                      : AppColors.redWarmColor,
                ),
              ),
            ),
            SizedBox(
              width: maxWidth / 7,
              child: GlobalActivityButton(
                icon: GeneralIcons.info,
                onTap: controller.showInfo,
                color: AppColors.lightBlue,
              ),
            ),
          ],
        );
      }),
    );
  }
}
