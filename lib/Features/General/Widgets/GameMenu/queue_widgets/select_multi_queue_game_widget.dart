import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Components/game_type_convertor.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_frame_wrapper.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/General/Widgets/game_button.dart';
import 'package:refreshed/refreshed.dart';

class SelectMultiQueueGameWidget extends StatelessWidget {
  const SelectMultiQueueGameWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final gameTypesParts = MultiGameTypes.values.toList();
    final int gamesLength = gameTypesParts.length;
    List<DropdownMenuEntry<MultiGameTypes>>? items = [];
    for (var i = 0; i < gamesLength; i++) {
      final value = gameTypesParts[i];
      items.add(
        DropdownMenuEntry<MultiGameTypes>(
          value: value,
          label: value.name.tr,
          leadingIcon: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: AssetImage(MultiGameTypeConvertor.toGameImage(value)),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: AppColors.darkColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          labelWidget: Text(
            value.name.tr,
            style: const TextStyle(
              color: AppColors.darkColor,
            ),
          ),
        ),
      );
    }
    return GlobalFrameWrapper(
      padding: AppSpacings.s50All,
      frame: AppImages.dialog3,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemBuilder: (ctx, index) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: GameButtonWidget(
            onTap: () {
              Get.closeAllBottomSheets();
              Get.toNamed(AppRoutes.multiQueue,
                  arguments: MultiGameTypes.values[index]);
            },
            image: MultiGameTypeConvertor.toGameImage(
                MultiGameTypes.values[index]),
            text: MultiGameTypes.values[index].name,
            imageColor: null,
            fontSize: 18,
          ),
        ),
        itemCount: gamesLength,
      ),
    );
  }
}
