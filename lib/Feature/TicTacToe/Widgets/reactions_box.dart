import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';

class ReactionsBox extends StatelessWidget {
  const ReactionsBox({
    super.key,
    required this.onEachTap,
  });

  final Function(int) onEachTap;

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
            onEachTap(index + 1);
          },
          child: Image.asset(
            ReactionIcons().reactionIconsPath(index + 1),
            color: Colors.amber,
          ),
        ),
        itemCount: ReactionIcons.reactionsCount,
      ),
    );
  }
}
