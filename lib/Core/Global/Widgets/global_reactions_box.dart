import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class GlobalReactionsBox extends StatelessWidget {
  const GlobalReactionsBox({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s15All,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 25,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => InkWell(
          onTap: () {
            Get.find<GameSocketManager>().sendReaction(index + 1);
            Get.closeAllBottomSheets();
            if (onTap != null) {
              onTap!();
            }
          },
          child: Image.asset(
            ReactionIcons().generalIconsPath(index + 1),
            color: AppColors.lightColor,
          ),
        ),
        itemCount: ReactionIcons.reactionsCount,
      ),
    );
  }
}
