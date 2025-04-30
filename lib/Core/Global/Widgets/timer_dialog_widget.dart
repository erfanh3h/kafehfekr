import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/route_manager.dart';

class TimerDialogWidget extends StatefulWidget {
  const TimerDialogWidget({
    super.key,
    this.maxTime = 3,
  });

  final int maxTime;

  @override
  State<TimerDialogWidget> createState() => _TimerDialogWidgetState();
}

class _TimerDialogWidgetState extends State<TimerDialogWidget> {
  int maxTime = 0;
  late Timer? timer;
  @override
  void initState() {
    setState(() {
      maxTime = widget.maxTime;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (maxTime == 0) {
          timer.cancel();
          Get.closeDialog();
        } else {
          setState(() {
            maxTime -= 1;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    try {
      timer!.cancel();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s20All,
      child: Center(
        child: GlobalFadeInOutWidget(
          animationTime: 500,
          child: Text(
            maxTime.toString(),
            style: const TextStyle(
              fontSize: 120,
              color: AppColors.lightColor,
              fontFamily: FontFamilies.playPen,
            ),
          ),
        ),
      ),
    );
  }
}
