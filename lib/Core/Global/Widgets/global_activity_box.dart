import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const GlobalActivityButton(
            icon: GeneralIcons.death,
            onTap: FunctionsLibraryClass.surrenderFunction,
          ),
          GlobalActivityButton(
            icon: ReactionIcons().generalIconsPath(5),
            onTap: controller.showReactionBox,
          ),
          Obx(
            () => GlobalActivityButton(
              icon: controller.showReactions.value
                  ? GeneralIcons.enableReaction
                  : GeneralIcons.disableReaction,
              onTap: controller.changeShowReactionStatus,
            ),
          ),
        ],
      ),
    );
  }
}
