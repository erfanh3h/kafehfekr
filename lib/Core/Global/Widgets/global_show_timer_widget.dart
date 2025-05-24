import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

import '../Components/timer.dart';

class GlobalShowTimerWidget extends StatelessWidget {
  const GlobalShowTimerWidget({
    super.key,
    this.color,
    this.username,
  });

  final Color? color;
  final String? username;

  @override
  Widget build(BuildContext context) {
    final TimerCompanent controller = Get.find<TimerCompanent>();
    return Directionality(
      textDirection: color != null && color == AppColors.imageRedColor
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: GlobalFrameWrapper(
        frame: AppImages.frame4,
        padding: AppSpacings.s10All,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 75,
              height: 40,
              child: Center(
                child: GetBuilder<TimerCompanent>(builder: (context) {
                  return Obx(
                    () => Text(
                      controller.timerLabel.value,
                      style: TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 45,
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
            ),
            if (username != null)
              Container(
                padding: AppSpacings.s3Vertical,
                margin: AppSpacings.s5Bottom,
                decoration: BoxDecoration(
                  color: color ?? Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 65,
                child: Text(
                  username != null ? username! : "",
                  style: const TextStyle(
                    fontFamily: FontFamilies.playPen,
                    fontSize: 14,
                    color: AppColors.lightColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
