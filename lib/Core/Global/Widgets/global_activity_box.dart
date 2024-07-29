import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_activity_button.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';

class GlobalActivityBox extends StatelessWidget {
  const GlobalActivityBox({
    super.key,
    required this.surrenderFunction,
    required this.reactionFunction,
    required this.changeShowReactionFunction,
    required this.showReaction,
  });

  final VoidCallback surrenderFunction;
  final VoidCallback reactionFunction;
  final VoidCallback changeShowReactionFunction;
  final bool showReaction;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: GeneralGameConsts.maxGameWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GlobalActivityButton(
            icon: GeneralIcons.death,
            onTap: surrenderFunction,
          ),
          GlobalActivityButton(
            icon: ReactionIcons().generalIconsPath(5),
            onTap: reactionFunction,
          ),
          GlobalActivityButton(
            icon: showReaction
                ? GeneralIcons.enableReaction
                : GeneralIcons.disableReaction,
            onTap: changeShowReactionFunction,
          ),
        ],
      ),
    );
  }
}
