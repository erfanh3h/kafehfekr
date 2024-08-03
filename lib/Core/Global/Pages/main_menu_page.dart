import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';

class MainMenuPage extends BaseView<GlobalController> {
  const MainMenuPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background1),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GlobalInputBox(
                label: "id",
                controller: controller.idController,
              ),
              GlobalInputBox(
                label: "gameId",
                controller: controller.gameIdController,
              ),
            ],
          )
        ],
      ),
    );
  }
}
