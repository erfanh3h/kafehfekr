import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Feature/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';

class AuthController extends BaseController {
  final AuthRepository authRepo;

  AuthController({required this.authRepo});

  TextEditingController phoneController = TextEditingController();
  TextEditingController codeontroller = TextEditingController();

  RxBool isPhonePhase = RxBool(true);
  RxBool isSendingData = RxBool(false);

  enterUser() {
    // Get.find<GlobalController>().setUserData(idController.text);
    // Get.find<GlobalController>().checkLoginStatus();
    // isPhonePhase.value = false;
    isSendingData.value = true;
  }

  sendCode() {
    // Get.find<GlobalController>().setUserData(idController.text);
    // Get.find<GlobalController>().checkLoginStatus();
    isPhonePhase.value = true;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
