import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Ten/Controllers/ten_controller.dart';
import 'package:kafehfekr/Feature/Ten/Widgets/ten_drag_target_number.dart';
import 'package:kafehfekr/Feature/Ten/Widgets/ten_drag_target_operator.dart';
import 'package:kafehfekr/Feature/Ten/Widgets/ten_draggable_number_widget.dart';
import 'package:kafehfekr/Feature/Ten/Widgets/ten_draggable_operator_widget.dart';
import 'package:refreshed/refreshed.dart';

class TenBoardWidget extends StatelessWidget {
  const TenBoardWidget({
    super.key,
    required this.controller,
  });

  final TenController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        // padding: AppSpacings.s20All,
        height:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        width:
            (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.result.toStringAsPrecision(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.lightColor,
                fontSize: 25,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 30),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Card(
                child: Padding(
                  padding: AppSpacings.s10All,
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
              ),
            ),
            const SizedBox(height: 15),
            Card(
              color: AppColors.blueWarmColor.withOpacity(.4),
              child: Padding(
                padding: AppSpacings.s20All,
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
            ),
            const SizedBox(height: 25),
            Opacity(
              opacity: controller.letSendResult.value ? 1 : .5,
              child: SizedBox(
                width: 100,
                height: 50,
                child: GlobalButtonWidget(
                  onTap: controller.sendResult,
                  text: AppTexts.accept.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
