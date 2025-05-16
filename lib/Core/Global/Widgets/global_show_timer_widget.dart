import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

import '../Components/timer.dart';

class GlobalShowTimerWidget extends StatelessWidget {
  const GlobalShowTimerWidget({
    super.key,
    this.color,
    this.needTimerIcon = true,
  });

  final Color? color;
  final bool needTimerIcon;

  @override
  Widget build(BuildContext context) {
    final TimerCompanent controller = Get.find<TimerCompanent>();
    return Directionality(
      textDirection: color != null && color == AppColors.imageRedColor
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (color != null && needTimerIcon) const SizedBox(width: 30),
          Container(
            padding: AppSpacings.s10All,
            width: 75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.black54, (color ?? AppColors.transparent)],
                stops: const [0, 0.4],
              ),
              // color: color ?? AppColors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.white,
                width: 1,
              ),
            ),
            child: GetBuilder<TimerCompanent>(builder: (context) {
              return Obx(
                () => Text(
                  controller.timerLabel.value,
                  style: TextStyle(
                    fontFamily: FontFamilies.dastnevis,
                    fontSize: 26,
                    height: .7,
                    foreground: Paint()
                      ..strokeWidth = 1.5
                      ..color = AppColors.lightColor
                      ..style = PaintingStyle.stroke,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
          if (color != null && needTimerIcon) const SizedBox(width: 5),
          if (color != null && needTimerIcon)
            GlobalFadeInOutWidget(
              child: Image.asset(
                GeneralIcons.timeCounter,
                color: AppColors.lightColor,
                height: 25,
                width: 25,
              ),
            ),
        ],
      ),
    );
  }
}
