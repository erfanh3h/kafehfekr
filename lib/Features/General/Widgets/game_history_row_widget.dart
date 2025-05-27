import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Features/General/Widgets/text_number_widget.dart';
import 'package:refreshed/refreshed.dart';

class GameHistoryRowWidget extends StatelessWidget {
  const GameHistoryRowWidget({
    super.key,
    required this.data,
    required this.name,
  });

  final (int?, int?, int?) data;
  final String name;
  @override
  Widget build(BuildContext context) {
    int winNumber = data.$1 ?? 0;
    int drawNumber = data.$2 ?? 0;
    int loseNumber = data.$3 ?? 0;
    bool mustShowBox =
        (winNumber + drawNumber + loseNumber) != 0 ? true : false;
    return mustShowBox
        ? GlobalFrameWrapper(
            frame: AppImages.frame4,
            padding: AppSpacings.s5All,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 20,
                      fontFamily: FontFamilies.hekayat,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 5,
                        child: TextNumberWidget(
                            number: drawNumber, text: AppTexts.draw.tr),
                      ),
                      Expanded(
                        flex: 7,
                        child: TextNumberWidget(
                            number: winNumber, text: AppTexts.win.tr),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextNumberWidget(
                            number: loseNumber, text: AppTexts.lose.tr),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
