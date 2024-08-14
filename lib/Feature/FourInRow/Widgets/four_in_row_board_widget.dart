import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Feature/FourInRow/Controllers/four_in_row_controller.dart';
import 'package:kafehfekr/Feature/FourInRow/Widgets/four_in_row_piece.dart';
import 'package:kafehfekr/Feature/FourInRow/Widgets/four_in_row_selection_button.dart';
import 'package:refreshed/refreshed.dart';

class FourInRowBoardWidget extends StatelessWidget {
  const FourInRowBoardWidget({
    super.key,
    required this.controller,
  });

  final FourInRowController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 25),
            child: Container(
              padding: AppSpacings.s5All,
              height: 70,
              width:
                  (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Card(
                  child: Padding(
                    padding: AppSpacings.s15Horizental,
                    child: Row(
                      children: [
                        for (int i = 0; i < 8; i++)
                          Expanded(
                            child: FourInRowSelectionButton(
                              index: i,
                              onTap: controller.onSelectionTap,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: AppSpacings.s5All,
            height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
            width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
            child: Obx(
              () => Directionality(
                textDirection: TextDirection.ltr,
                child: Card(
                  child: Padding(
                    padding: AppSpacings.s15All,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (ctx, index) => FourInRowPiece(
                        peaceData: controller.pieces[index].value,
                      ),
                      itemCount: controller.pieces.length,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
