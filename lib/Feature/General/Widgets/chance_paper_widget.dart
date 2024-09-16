import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_fade_in_out_widget.dart.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Controllers/store_controller.dart';
import 'package:refreshed/refreshed.dart';

class ChancePaperWidget extends StatelessWidget {
  const ChancePaperWidget({
    super.key,
    required this.controller,
  });

  final StoreController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemBuilder: (ctx, index) => Container(
              decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightColor)),
              child: Center(
                child: Obx(
                  () => controller.isGettingCoin.value
                      ? GlobalFadeInOutWidget(
                          animationTime: 100,
                          child: Text(
                            controller.indexToValue(index),
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: FontFamilies.dastnevis,
                              color: AppColors.lightColor,
                            ),
                          ),
                        )
                      : Text(
                          controller.indexToValue(index),
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: FontFamilies.dastnevis,
                            color: AppColors.lightColor,
                          ),
                        ),
                ),
              ),
            ),
            itemCount: 9,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Obx(
            () => SizedBox(
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  Text(
                    AppTexts.coin8Hours.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: FontFamilies.dastnevis,
                      color: AppColors.lightColor,
                    ),
                  ),
                  const Spacer(),
                  controller.canGetFreeCoin.value
                      ? Text(
                          AppTexts.coinReady.tr,
                          style: const TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 15,
                          ),
                        )
                      : RemainTimeWidget(
                          maxTime: controller.remainTime.value,
                        ),
                  const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    child: GlobalButtonWidget(
                      onTap: controller.getFreeCoin,
                      text: AppTexts.chancePaper.tr,
                      fontColor: AppColors.darkColor,
                      color: AppColors.goldenColor.withOpacity(
                          controller.canGetFreeCoin.value ? 1 : .25),
                      isLoading: controller.isGettingCoin.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RemainTimeWidget extends StatefulWidget {
  const RemainTimeWidget({
    super.key,
    required this.maxTime,
  });

  final int maxTime;

  @override
  State<RemainTimeWidget> createState() => _RemainTimeWidgetState();
}

class _RemainTimeWidgetState extends State<RemainTimeWidget> {
  int maxTime = 0;
  late Timer? timer;
  String convertedDate = '';
  @override
  void initState() {
    setState(() {
      maxTime = widget.maxTime.abs();
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
          setState(() {
            Duration now = Duration(seconds: maxTime);
            convertedDate =
                "${now.inHours.toString().padLeft(2, '0')} : ${now.inMinutes.remainder(60).toString().padLeft(2, '0')} : ${now.inSeconds.remainder(60).toString().padLeft(2, '0')}";
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
      convertedDate,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontFamily: FontFamilies.dastnevis,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textDirection: TextDirection.ltr,
    );
  }
}
