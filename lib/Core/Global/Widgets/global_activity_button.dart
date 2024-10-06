import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';

class GlobalActivityButton extends StatelessWidget {
  const GlobalActivityButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.backgroundColor,
    required this.text,
    this.isNotActive = false,
    this.needTimerWidget = true,
  });

  final VoidCallback? onTap;
  final String icon;
  final Color? color;
  final Color? backgroundColor;
  final String text;
  final bool isNotActive;
  final bool needTimerWidget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isNotActive ? onTap : null,
      child: Container(
        padding: AppSpacings.s2All,
        decoration: BoxDecoration(
          color: isNotActive ? Colors.grey : backgroundColor,
          // shape: BoxShape.circle,
          border: Border.all(color: AppColors.lightColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: !isNotActive
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      icon,
                      width: 25,
                      height: 25,
                      color: color ?? AppColors.lightColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: FontFamilies.dastnevis,
                        fontSize: 12,
                        color: color ?? Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            icon,
                            width: 25,
                            height: 25,
                            color: color ?? AppColors.lightColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontFamily: FontFamilies.dastnevis,
                              fontSize: 12,
                              color: color ?? Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (needTimerWidget)
                    const Center(child: TimerWidget(maxTime: 5)),
                ],
              ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    super.key,
    required this.maxTime,
  });

  final int maxTime;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
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
    return Text(
      maxTime.toString(),
      style: const TextStyle(
        fontSize: 32,
        color: AppColors.darkColor,
        fontFamily: FontFamilies.dastnevis,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
    );
  }
}
