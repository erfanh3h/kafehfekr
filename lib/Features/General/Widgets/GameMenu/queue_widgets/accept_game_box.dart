import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:refreshed/refreshed.dart';

class AcceptGameBox extends StatefulWidget {
  const AcceptGameBox({
    super.key,
    this.onAccept,
    this.onReject,
    this.duration = 20,
  });
  final Function? onAccept;
  final Function? onReject;
  final int duration;

  @override
  State<AcceptGameBox> createState() => _AcceptGameBoxState();
}

class _AcceptGameBoxState extends State<AcceptGameBox> {
  final timerController = TimerCompanent();
  bool isLoading = false;

  @override
  void initState() {
    timerController.startTimer(widget.duration);
    super.initState();
  }

  @override
  void dispose() {
    timerController.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalFrameWrapper(
      frame: AppImages.dialog3,
      padding: AppSpacings.s30All,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLoading
            ? [
                const SizedBox(height: 50),
                const GlobalWaitWidget(),
                const SizedBox(height: 50),
              ]
            : [
                Obx(
                  () => Text(
                    timerController.timerLabel.value,
                    style: const TextStyle(
                      fontFamily: FontFamilies.dastnevis,
                      fontSize: 50,
                      color: AppColors.lightColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // const SizedBox(height: 20),
                Text(
                  AppTexts.areYouRdyToStart.tr,
                  style: const TextStyle(
                    color: AppColors.lightColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                GlobalButtonWidget(
                  onTap: () {
                    if (widget.onAccept != null) {
                      widget.onAccept!();
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  text: AppTexts.imReady.tr,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (widget.onReject != null) {
                      widget.onReject!();
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: Text(
                    AppTexts.cancel.tr,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
      ),
    );
  }
}
