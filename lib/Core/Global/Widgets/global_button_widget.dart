import 'package:flutter/material.dart';
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
    this.fontColor,
  });

  final VoidCallback onTap;
  final String text;
  final Color? color;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.tapButton);
        onTap();
      },
      child: Container(
        padding: AppSpacings.s5Vertical3Horizental,
        decoration: BoxDecoration(
          color: color ?? AppColors.blueWarmColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              foreground: Paint()
                ..strokeWidth = 1
                ..color = fontColor ?? AppColors.lightColor
                ..style = PaintingStyle.stroke,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
