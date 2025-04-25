import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ten/Controllers/ten_offline_controller.dart';
import 'package:kafehfekr/Games/Ten/Widgets/ten_drag_target_number.dart';
import 'package:kafehfekr/Games/Ten/Widgets/ten_drag_target_operator.dart';
import 'package:kafehfekr/Games/Ten/Widgets/ten_draggable_number_widget.dart';
import 'package:kafehfekr/Games/Ten/Widgets/ten_draggable_operator_widget.dart';
import 'package:refreshed/refreshed.dart';

class TenOfflineBoardWidget extends StatelessWidget {
  const TenOfflineBoardWidget({
    super.key,
    required this.controller,
  });

  final TenOfflineController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: AppSpacings.s10All,
        constraints: BoxConstraints(
          minHeight:
              (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        ),
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.result.value.toStringAsPrecision(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 45,
                fontFamily: FontFamilies.dastnevis,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 15),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TenDragTargetOperatorWidget(
                      value: controller.operatorValues[0].value,
                      onAccept: controller.onOperatorAccept,
                      onRemove: controller.onOperatorRemove,
                      index: 0,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetNumberWidget(
                      value: controller.numberValues[0].value,
                      onAccept: controller.onNumberAccept,
                      onRemove: controller.onNumberRemove,
                      index: 0,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetOperatorWidget(
                      value: controller.operatorValues[1].value,
                      onAccept: controller.onOperatorAccept,
                      onRemove: controller.onOperatorRemove,
                      index: 1,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetNumberWidget(
                      value: controller.numberValues[1].value,
                      onAccept: controller.onNumberAccept,
                      onRemove: controller.onNumberRemove,
                      index: 1,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetOperatorWidget(
                      value: controller.operatorValues[2].value,
                      onAccept: controller.onOperatorAccept,
                      onRemove: controller.onOperatorRemove,
                      index: 2,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetNumberWidget(
                      value: controller.numberValues[2].value,
                      onAccept: controller.onNumberAccept,
                      onRemove: controller.onNumberRemove,
                      index: 2,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetOperatorWidget(
                      value: controller.operatorValues[3].value,
                      onAccept: controller.onOperatorAccept,
                      onRemove: controller.onOperatorRemove,
                      index: 3,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetNumberWidget(
                      value: controller.numberValues[3].value,
                      onAccept: controller.onNumberAccept,
                      onRemove: controller.onNumberRemove,
                      index: 3,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: TenDragTargetOperatorWidget(
                      value: controller.operatorValues[4].value,
                      onAccept: controller.onOperatorAccept,
                      onRemove: controller.onOperatorRemove,
                      index: 4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: AppSpacings.s20All,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white70),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TenDraggableNumberWidget(
                          value: controller.numbers[0].value),
                      TenDraggableNumberWidget(
                          value: controller.numbers[1].value),
                      TenDraggableNumberWidget(
                          value: controller.numbers[2].value),
                      TenDraggableNumberWidget(
                          value: controller.numbers[3].value),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TenDraggableOperatorWidget(
                            value: controller.operators[0].value),
                        TenDraggableOperatorWidget(
                            value: controller.operators[1].value),
                        TenDraggableOperatorWidget(
                            value: controller.operators[2].value),
                        TenDraggableOperatorWidget(
                            value: controller.operators[3].value),
                        TenDraggableOperatorWidget(
                            value: controller.operators[4].value),
                        TenDraggableOperatorWidget(
                            value: controller.operators[5].value),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Opacity(
              opacity: controller.letSendResult.value ? 1 : .5,
              child: GlobalButtonWidget(
                onTap: controller.sendResult,
                text: AppTexts.accept.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
