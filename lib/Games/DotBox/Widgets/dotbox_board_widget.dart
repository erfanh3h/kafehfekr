import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/DotBox/Controllers/dotbox_controller.dart';
import 'package:kafehfekr/Games/DotBox/Widgets/dotbox_box_widget.dart';
import 'package:kafehfekr/Games/DotBox/Widgets/dotbox_horizental_line_widget.dart';
import 'package:kafehfekr/Games/DotBox/Widgets/dotbox_vertical_line_widget.dart';
import 'package:refreshed/refreshed.dart';

class DotBoxBoardWidget extends StatelessWidget {
  const DotBoxBoardWidget({
    super.key,
    required this.controller,
  });

  final DotBoxController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: AppSpacings.s5All,
        margin: AppSpacings.s10All,
        height: 325,
        width: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData: controller.linePeaces.value[index].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[5].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[0].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[6].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[1].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[7].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[2].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[8].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[3].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[9].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[4].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[10].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData:
                            controller.linePeaces.value[index + 11].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[16].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[5].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[17].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[6].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[18].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[7].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[19].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[8].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[20].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[9].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[21].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData:
                            controller.linePeaces.value[index + 22].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[27].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[10].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[28].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[11].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[29].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[12].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[30].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[13].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[31].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[14].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[32].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData:
                            controller.linePeaces.value[index + 33].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[38].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[15].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[39].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[16].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[40].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[17].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[41].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[18].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[42].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[19].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[43].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData:
                            controller.linePeaces.value[index + 44].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[49].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[20].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[50].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[21].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[51].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[22].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[52].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[23].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[53].value,
                      onTap: controller.onEachButtonTap,
                    ),
                    DotBoxWidget(
                        peaceData: controller.boxPeaces.value[24].value),
                    DotBoxVerticalLineWidget(
                      peaceData: controller.linePeaces.value[54].value,
                      onTap: controller.onEachButtonTap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
                child: Transform.translate(
                  offset: const Offset(3, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) => Obx(
                      () => DotBoxHorizentalLineWidget(
                        peaceData:
                            controller.linePeaces.value[index + 55].value,
                        onTap: controller.onEachButtonTap,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
