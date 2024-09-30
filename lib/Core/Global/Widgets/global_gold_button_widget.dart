import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

import '../Components/sound_player.dart';

class GlobalGoldButtonWidget extends StatelessWidget {
  const GlobalGoldButtonWidget({
    super.key,
    required this.onTap,
    required this.goldCount,
    this.text = "",
    this.color,
    this.borderColor,
    this.fontColor,
    this.height,
    this.width,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final int goldCount;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? fontColor;
  final double? height;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoading) return;
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.tapButton);
        onTap();
      },
      child: Container(
        padding: AppSpacings.s10All,
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.blueWarmColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: borderColor ?? AppColors.darkColor, width: 2),
          // gradient: LinearGradient(
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   colors: [
          //     const Color.fromARGB(1, 212, 133, 126),
          //     color ?? AppColors.blueWarmColor,
          //   ],
          // ),
        ),
        child: Center(
          child: isLoading
              ? GlobalLoadingWidget(color: fontColor ?? AppColors.lightColor)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        color: fontColor ?? AppColors.lightColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      goldCount.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: fontColor ?? AppColors.lightColor,
                        fontFamily: FontFamilies.playPen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      GeneralIcons.coin,
                      color: AppColors.goldenColor,
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
