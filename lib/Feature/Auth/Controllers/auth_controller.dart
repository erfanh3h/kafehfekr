import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/Auth/Core/auth_repository.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';
import 'package:refreshed/refreshed.dart';

class AuthController extends BaseController {
  final AuthRepository authRepo;

  AuthController({required this.authRepo});

  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  RxBool isPhonePhase = RxBool(true);
  RxBool isSendingData = RxBool(false);

  enterUser() async {
    isSendingData.value = true;
    final result = await authRepo.enterUser(phone: phoneController.text);
    if (result.resultData != null) {
      isPhonePhase.value = !result.resultData!;
    }
    isSendingData.value = false;
  }

  sendCode() async {
    // Get.find<GlobalController>().setUserData(idController.text);
    // Get.find<GlobalController>().checkLoginStatus();
    isSendingData.value = true;
    final result = await authRepo.enterCode(
      phone: phoneController.text,
      code: codeController.text,
    );
    if (result.resultData != null) {
      UserModel? userData = result.resultData!.$1;
      if (userData != null) {
        Get.find<GlobalController>()
            .setUserData(userData.id, result.resultData!.$2);
        if (userData.name != "") {
          Get.offAllNamed(AppRoutes.main);
        } else {
          Get.offAllNamed(AppRoutes.username);
        }
      }
    }
    isSendingData.value = false;
  }

  sendUsername() async {
    // Get.find<GlobalController>().checkLoginStatus();
    isSendingData.value = true;
    final result = await authRepo.completeUser(
      phone: phoneController.text,
      username: usernameController.text,
    );
    if (result.resultData != null) {
      Get.offAllNamed(AppRoutes.main);
    }
    isSendingData.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
