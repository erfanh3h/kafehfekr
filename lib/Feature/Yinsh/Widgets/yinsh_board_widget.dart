import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/Yinsh/Controllers/yinsh_controller.dart';
import 'package:kafehfekr/Feature/Yinsh/Widgets/yinsh_board_view_widget.dart';
import 'package:kafehfekr/Feature/Yinsh/Widgets/yinsh_button.dart';
import 'package:refreshed/refreshed.dart';

class YinshBoardWidget extends StatelessWidget {
  YinshBoardWidget({
    super.key,
    required this.controller,
  });

  final YinshController controller;

  final List<(double, double)> positions = [
    (0, -126),
    (0, -42),
    (0, 42),
    (0, 126),
    (35, -250),
    (35, -168),
    (35, -84),
    (35, 0),
    (35, 84),
    (35, 168),
    (35, 250),
    (70, -292),
    (70, -208),
    (70, -126),
    (70, -42),
    (70, 42),
    (70, 126),
    (70, 208),
    (70, 292),
    (105, -334),
    (105, -250),
    (105, -168),
    (105, -84),
    (105, 0),
    (105, 84),
    (105, 168),
    (105, 250),
    (105, 334),
    (140, -370),
    (140, -292),
    (140, -208),
    (140, -126),
    (140, -42),
    (140, 42),
    (140, 126),
    (140, 208),
    (140, 292),
    (140, 370),
    (175, -334),
    (175, -250),
    (175, -168),
    (175, -84),
    (175, 0),
    (175, 84),
    (175, 168),
    (175, 250),
    (175, 334),
    (210, -370),
    (210, -292),
    (210, -208),
    (210, -126),
    (210, -42),
    (210, 42),
    (210, 126),
    (210, 208),
    (210, 292),
    (210, 370),
    (245, -334),
    (245, -250),
    (245, -168),
    (245, -84),
    (245, 0),
    (245, 84),
    (245, 168),
    (245, 250),
    (245, 334),
    (280, -292),
    (280, -208),
    (280, -126),
    (280, -42),
    (280, 42),
    (280, 126),
    (280, 208),
    (280, 292),
    (315, -250),
    (315, -168),
    (315, -84),
    (315, 0),
    (315, 84),
    (315, 168),
    (315, 250),
    (350, -126),
    (350, -42),
    (350, 42),
    (350, 126),
  ];
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .95,
      child: SizedBox(
        height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
        // width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth) * .95,
        child: LayoutBuilder(builder: (context, cons) {
          return Container(
            margin: AppSpacings.s10Vertical,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: cons.maxHeight,
                    width: cons.maxWidth,
                    child: const YinshBoardViewWidget(),
                  ),
                ),
                for (int i = 0; i < positions.length; i++)
                  Positioned(
                    top: positions[i].$1,
                    left: positions[i].$2,
                    right: 0,
                    child: YinshButton(
                      pieceData: controller.peaces[i].value,
                      onTap: (_) {},
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
