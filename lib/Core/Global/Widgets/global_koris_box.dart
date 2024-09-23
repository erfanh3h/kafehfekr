import 'package:kafehfekr/Core/Network/game_socket.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class GlobalKorisBox extends StatelessWidget {
  const GlobalKorisBox({
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
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (ctx, index) => InkWell(
          onTap: () {
            Get.find<GameSocketManager>().sendReaction(index + 101);
            Get.closeAllBottomSheets();
            if (onTap != null) {
              onTap!();
            }
          },
          child: Container(
            padding: AppSpacings.s5All,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                koris[index],
                style: const TextStyle(
                  fontFamily: FontFamilies.hekayat,
                  fontSize: 18,
                  color: AppColors.lightColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        itemCount: koris.length,
      ),
    );
  }
}
