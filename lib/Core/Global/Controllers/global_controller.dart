import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

// import '../Core/global_repository.dart';

class GlobalController extends GetxController {
  // final AuthRepository authRepo;
  // final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  // GlobalController(this.globalRepo);

  final Rx<String?> _userId = Rx(null);
  String? get userId => _userId.value;
  set user(String? userId) {
    _userId.value = userId;
  }

  final Rx<String?> _userEmail = Rx(null);
  String? get userEmail => _userEmail.value;
  set userEmail(String? userEmail) {
    _userEmail.value = userEmail;
  }

  RxBool isLoadingProfile = RxBool(true);

  Future<void> fetchUserData() async {
    isLoadingProfile.value = true;
    // final result = await authRepo.getActiveUser();
    // if (result.resultData != null) {
    //   _userId.value = result.resultData;
    // }
    isLoadingProfile.value = false;
  }

  void changeLanguegue() {
    if ((Get.locale ?? const Locale('en')).languageCode == 'en') {
      Get.updateLocale(const Locale('fa'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  void swapTheme() async {
    if (currentTheme == ThemeMode.dark) {
      Get.changeThemeMode(ThemeMode.light);
      currentTheme = ThemeMode.light;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      currentTheme = ThemeMode.dark;
    }
    // await globalRepo.writeIsLightMode(data: currentTheme == ThemeMode.light);
  }

  void changeTheme(bool isLightMode) async {
    if (isLightMode) {
      Get.changeThemeMode(ThemeMode.light);
      currentTheme = ThemeMode.light;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      currentTheme = ThemeMode.dark;
    }
    // await globalRepo.writeIsLightMode(data: currentTheme == ThemeMode.light);
  }

  Future<void> readPreTheme() async {
    //save theme base on isDarkMode
    // final readResult = await globalRepo.getIsLightMode();
    // if (readResult != null) {
    //   changeTheme(readResult);
    // } else {
    //   changeTheme(true);
    // }
  }

  @override
  void onInit() async {
    readPreTheme();
    // await fetchUserData();
    // if (_userId.value != null) {
    //   _userEmail.value = await globalRepo.getUserEmail();
    // }
    super.onInit();
  }
}
