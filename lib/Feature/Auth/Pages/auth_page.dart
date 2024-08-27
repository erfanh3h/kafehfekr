import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_view.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_button_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_input_box.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/Auth/Controllers/auth_controller.dart';
import 'package:refreshed/refreshed.dart';

class AuthPage extends BaseView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlobalInputBox(
          label: "userid",
          controller: controller.idController,
        ),
        const SizedBox(height: 40),
        GlobalButtonWidget(
          onTap: controller.setUserId,
          text: AppTexts.accept.tr,
        ),
      ],
    );
  }
}
