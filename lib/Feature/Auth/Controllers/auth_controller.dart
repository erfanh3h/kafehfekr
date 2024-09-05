import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
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
    if (phoneController.text.length != 10 ||
        !phoneController.text.startsWith("9")) {
      DialogComponent().showToast(label: AppTexts.enterPhoneCorrectly.tr);
      return;
    }
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
        await Get.find<GlobalController>()
            .setUserData(userData.id, result.resultData!.$2);
        if (userData.name != "") {
          await Get.find<GlobalController>().fetchUserData();
          Get.offAllNamed(AppRoutes.main);
          Get.find<SoundPlayerComponent>().startPlayMusic(isGame: false);
        } else {
          Get.offAllNamed(AppRoutes.username);
        }
      }
    }
    isSendingData.value = false;
  }

  sendUsername() async {
    isSendingData.value = true;
    final result = await authRepo.completeUser(
      phone: phoneController.text,
      username: usernameController.text,
    );
    if (result.resultData != null) {
      Get.find<GlobalController>().fetchUserData();
      Get.offAllNamed(AppRoutes.main);
      Get.find<SoundPlayerComponent>().startPlayMusic(isGame: false);
    }
    isSendingData.value = false;
  }

  @override
  void onInit() async {
    final GlobalController globalcontroller = Get.find<GlobalController>();
    if (globalcontroller.myData.value != null) {
      phoneController.text = globalcontroller.myData.value!.phone;
    }
    super.onInit();
  }
}
