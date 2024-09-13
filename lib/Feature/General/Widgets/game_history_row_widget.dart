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
                  flex: 3,
                  child: Card(
                    color: AppColors.lightColor.withOpacity(.35),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextNumberWidget(
                                number: drawNumber, text: AppTexts.draw.tr),
                          ),
                          const Padding(
                            padding: AppSpacings.s10Vertical,
                            child: VerticalDivider(color: AppColors.lightColor),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextNumberWidget(
                                number: winNumber, text: AppTexts.win.tr),
                          ),
                          const Padding(
                            padding: AppSpacings.s10Vertical,
                            child: VerticalDivider(color: AppColors.lightColor),
                          ),
                          Expanded(
                            child: TextNumberWidget(
                                number: loseNumber, text: AppTexts.lose.tr),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
