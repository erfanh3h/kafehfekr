import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';

class AvatarsSelectionBox extends StatelessWidget {
  const AvatarsSelectionBox({
    super.key,
    required this.onTap,
  });

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s15All,
      child: Column(
        children: [
          // Padding(
          //   padding: AppSpacings.s20Horizental10Vertical,
          //   child: Text(
          //     AppTexts.changeImagePrice.tr,
          //     style: const TextStyle(
          //       color: AppColors.lightColor,
          //       fontSize: 18,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 25,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  onTap(index + 1);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    AvatarIcons().generalAvatarPath(index + 1),
                    // color: AppColors.lightColor,
                  ),
                ),
              ),
              itemCount: AvatarIcons.avatarsCount,
            ),
          ),
        ],
      ),
    );
  }
}
