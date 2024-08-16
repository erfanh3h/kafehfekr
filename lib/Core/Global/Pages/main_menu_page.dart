import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Core/Resources/app_spacings.dart';
import 'package:refreshed/refreshed.dart';

class MainMenuPage extends BaseView<GlobalController> {
  const MainMenuPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background3),
          fit: BoxFit.fill,
        ),
      ),
      width: Get.size.width,
      height: Get.size.height,
      padding: AppSpacings.s10All,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: GlobalInputBox(
                  label: "id",
                  controller: controller.idController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GlobalInputBox(
                  label: "gameId",
                  controller: controller.gameIdController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (ctx, index) => GlobalButtonWidget(
                onTap: () {
                  Get.toNamed('/${GameTypes.values[index].name}');
                },
                text: GameTypes.values[index].name.tr,
                color: Colors.transparent.withOpacity(.5),
                fontColor: AppColors.lightColor,
              ),
              itemCount: GameTypes.values.length,
            ),
          ),
        ],
      ),
    );
  }
}
