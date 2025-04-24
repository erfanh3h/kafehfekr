import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/Pentago/Controllers/pentago_controller.dart';
import 'package:kafehfekr/Games/Pentago/Widgets/pentago_board_part_widget.dart';
import 'package:refreshed/refreshed.dart';

class PentagoBoardWidget extends StatelessWidget {
  PentagoBoardWidget({
    super.key,
    required this.controller,
  });

  final PentagoController controller;
  final List<List<int>> indexes = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8],
    [9, 10, 11, 12, 13, 14, 15, 16, 17],
    [18, 19, 20, 21, 22, 23, 24, 25, 26],
    [27, 28, 29, 30, 31, 32, 33, 34, 35],
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => controller.onRotationTap(1),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_left_down,
                  size: 35,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.onRotationTap(2),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_right_down,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => controller.onRotationTap(3),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_left_down,
                  size: 35,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.onRotationTap(4),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_right_down,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: AppSpacings.s5All,
                height:
                    (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
                width:
                    (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: PentagoPartWidget(
                                controller: controller,
                                indexes: indexes[0],
                                partIndex: 0,
                              ),
                            ),
                            Expanded(
                              child: PentagoPartWidget(
                                controller: controller,
                                indexes: indexes[1],
                                partIndex: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: PentagoPartWidget(
                                controller: controller,
                                indexes: indexes[2],
                                partIndex: 2,
                              ),
                            ),
                            Expanded(
                              child: PentagoPartWidget(
                                controller: controller,
                                indexes: indexes[3],
                                partIndex: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => controller.onRotationTap(6),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_left_up,
                  size: 35,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.onRotationTap(5),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_right_up,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () => controller.onRotationTap(8),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_left_up,
                  size: 35,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.onRotationTap(7),
                icon: const Icon(
                  CupertinoIcons.arrow_turn_right_up,
                  size: 35,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
