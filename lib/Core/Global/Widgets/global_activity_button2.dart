import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_focus_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';

class GlobalActivityButton2 extends StatelessWidget {
  const GlobalActivityButton2({
    super.key,
    this.icon,
    this.onTap,
    this.backgroundColor,
    this.fontColor,
    this.iconData,
    required this.text,
  });

  final VoidCallback? onTap;
  final String? icon;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? fontColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GlobalFocusWidget(
      onTap: onTap,
      child: GlobalFrameWrapper(
        width: 50,
        height: 50,
        frame: AppImages.button5,
        padding: EdgeInsets.zero,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Image.asset(
                  icon!,
                  width: 18,
                  height: 18,
                  color: fontColor ?? AppColors.lightColor,
                )
              else
                Icon(
                  iconData!,
                  size: 18,
                  color: fontColor ?? AppColors.lightColor,
                ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: FontFamilies.hekayat,
                  fontSize: 14,
                  color: fontColor ?? AppColors.lightColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
