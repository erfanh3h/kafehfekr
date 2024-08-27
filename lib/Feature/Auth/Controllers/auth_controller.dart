import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Feature/Auth/Core/auth_repository.dart';
import 'package:refreshed/refreshed.dart';

class AuthController extends BaseController {
  final AuthRepository authRepo;

  AuthController({required this.authRepo});

  TextEditingController idController = TextEditingController();

  setUserId() {
    Get.find<GlobalController>().setUserData(idController.text);
    Get.find<GlobalController>().checkLoginStatus();
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
