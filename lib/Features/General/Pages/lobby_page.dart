import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:kafehfekr/Features/General/Controllers/lobby_controller.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/joined_lobby_widget.dart';
import 'package:kafehfekr/Features/General/Widgets/LobbyPage/lobby_list_box.dart';
import 'package:refreshed/refreshed.dart';

class LobbyPage extends BaseView<LobbyController> {
  const LobbyPage({super.key});

  @override
  Widget loadingWidget() {
    return const GlobalLoadingWidget(
      color: AppColors.lightColor,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.size.height,
      width: Get.size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.background2),
          fit: BoxFit.fill,
        ),
      ),
      child: Obx(
        () => controller.joinedLobby.value != null
            ? JoinedLobbyWidget(
                lobby: controller.joinedLobby.value!,
                controller: controller,
              )
            : LobbyListBox(controller: controller),
      ),
    );
  }
}
