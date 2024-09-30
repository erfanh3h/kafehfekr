import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

import '../Components/sound_player.dart';

class GlobalButtonWidget extends StatelessWidget {
  const GlobalButtonWidget({
    super.key,
    required this.onTap,
    this.text = "",
    this.color,
    this.borderColor,
    this.fontColor,
    this.height,
    this.width,
    this.isLoading = false,
    this.fontSize,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? fontColor;
  final double? height;
  final double? width;
  final bool isLoading;
  final double? fontSize;

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
        padding: AppSpacings.s5Vertical3Horizental,
        height: height ?? 40.h,
        width: width ?? 140,
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
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize ?? 18,
                    color: fontColor ?? AppColors.lightColor,
                    // foreground: Paint()
                    //   ..strokeWidth = 1
                    //   ..color = fontColor ?? AppColors.lightColor
                    //   ..style = PaintingStyle.stroke,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
