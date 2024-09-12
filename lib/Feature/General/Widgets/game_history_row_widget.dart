import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Widgets/text_number_widget.dart';
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
        ? Container(
            margin: AppSpacings.s20Horizental5Vertical,
            padding: AppSpacings.s5Bottom,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.lightColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.lightColor,
                      fontSize: 25,
                      fontFamily: FontFamilies.dastnevis,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: TextNumberWidget(
                      number: winNumber, text: AppTexts.win.tr),
                ),
                Expanded(
                  child: TextNumberWidget(
                      number: drawNumber, text: AppTexts.draw.tr),
                ),
                Expanded(
                  child: TextNumberWidget(
                      number: loseNumber, text: AppTexts.lose.tr),
                )
              ],
            ),
          )
        : Container();
  }
}
