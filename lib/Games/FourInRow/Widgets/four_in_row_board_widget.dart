import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Games/FourInRow/Controllers/four_in_row_controller.dart';
import 'package:kafehfekr/Games/FourInRow/Widgets/four_in_row_piece.dart';
import 'package:kafehfekr/Games/FourInRow/Widgets/four_in_row_selection_button.dart';
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
            offset: const Offset(0, 15),
            child: GlobalFrameWrapper(
              frame: AppImages.board,
              padding: AppSpacings.s10All,
              height: 70,
              width:
                  (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: AppSpacings.s15Horizental,
                  child: Row(
                    spacing: 2,
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
          GlobalFrameWrapper(
            padding: AppSpacings.s5All,
            frame: AppImages.board,
            height: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
            width: (Get.size.width).clamp(100, GeneralGameConsts.maxGameWidth),
            child: Obx(
              () => Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: AppSpacings.s20All,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
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
        ],
      ),
    );
  }
}
