import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Core/Global/Models/config_model.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Features/Auth/Models/user_model.dart';
import 'package:refreshed/refreshed.dart';

// import '../Core/global_repository.dart';

class GlobalController extends BaseController {
  final GlobalRepository globalRepo = GlobalRepository();

  ThemeMode currentTheme = ThemeMode.light;

  // RxString activeQueueType = RxString('');
  // RxString activeQueueScoreType = RxString('');

  PageController pgCtrl = PageController(initialPage: 2);
  RxInt selectedPage = RxInt(2);
  TextEditingController gameIdController =
      TextEditingController(text: "gameId");

  String? userId;
  Rx<String?> token = Rx(null);
  String? activeGameId;
  String? activePreGameId;

  Rx<UserModel?> myData = Rx(null);
  RxBool isLoadingProfile = RxBool(true);
  RxBool isLoadingHistory = RxBool(false);

  // RxBool errorGetData = RxBool(false);

  RxBool isNoNetwork = RxBool(false);

  changePage(int page) {
    selectedPage.value = page;
    pgCtrl.jumpToPage(page);
  }

  checkLoginStatus({bool navigateToMain = true}) async {
    await removeData();
    bool isConfigOk = await getConfigData(navigateToMain: navigateToMain);
    token.value = await globalRepo.getDataFromStorage(key: StorageKeys.token);
    if (isConfigOk) {
      await fetchUserData();
      if (token.value != null) {
        if (myData.value!.name == "") {
          Get.offAllNamed(AppRoutes.username);
        } else {
          Get.offAllNamed(AppRoutes.main);
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            if (activeGameId != null && activeGameId!.isNotEmpty) {
              Get.toNamed(AppRoutes.gamePlay, arguments: activeGameId);
              // Get.toNamed('/$activeGameType', arguments: activeGameId);
            }
            if (activePreGameId != null && activePreGameId!.isNotEmpty) {
              Get.toNamed(AppRoutes.queue, arguments: activePreGameId);
            }
          });
        }
      } else {
        Get.offAllNamed(AppRoutes.auth);
      }
    }
  }

  tryReconnect() async {
    DialogComponent().showLoading();
    await checkLoginStatus(navigateToMain: false);
    Get.closeAllDialogs();
    if (myData.value != null) {
      isNoNetwork.value = false;
    }
  }

  Future<bool> getConfigData({bool navigateToMain = true}) async {
    final dataResult = await globalRepo.getConfigData();
    if (dataResult.resultData != null) {
      final ConfigModel data = dataResult.resultData!;
      if (!FunctionsLibraryClass.isVersionOk(
          appVersion, data.allowedVersion ?? "")) {
        Get.offAllNamed(AppRoutes.update);
        return false;
      }
      if (data.updateFinishDate!.difference(DateTime.now()).inSeconds > 0) {
        Get.offAllNamed(AppRoutes.maintence, arguments: data.updateFinishDate);
        return false;
      }
    }
    if (dataResult.errorData != null) {
      isNoNetwork.value = true;
      if (navigateToMain) {
        Get.offAllNamed(AppRoutes.main);
      }
      return false;
    }

    return true;
  }

  Future<void> fetchUserData() async {
    if (token.value != null) {
      isLoadingProfile.value = true;
      final dataResult = await globalRepo.getMyData();
      if (dataResult.resultData != null) {
        myData.value = dataResult.resultData!;
        // activeGameId = "gameId";
        activeGameId = myData.value!.openGameId;
        activePreGameId = myData.value!.openPreGameId;
      }
      final userIdData =
          await globalRepo.getDataFromStorage(key: StorageKeys.userId);
      if (userIdData != null) {
        userId = userIdData;
      }
      final gameMusicData =
          await globalRepo.getDataFromStorage(key: StorageKeys.gameMusic);
      if (gameMusicData != null) {
        if (gameMusicData == "0") {
          Get.find<SoundPlayerComponent>().changeLetPlayerSound(false);
        } else {
          Get.find<SoundPlayerComponent>().startPlayMusic();
        }
      } else {
        Get.find<SoundPlayerComponent>().startPlayMusic();
      }
    }
    isLoadingProfile.value = false;
  }

  Future<void> setUserData(String newUserId, String newToken) async {
    isLoadingProfile.value = true;
    await globalRepo.setDataOnStorage(
        key: StorageKeys.userId, value: newUserId);
    await globalRepo.setDataOnStorage(key: StorageKeys.token, value: newToken);
    userId = newUserId;
    token.value = newToken;
    isLoadingProfile.value = false;
    isNoNetwork.value = false;
  }

  Future<void> setActiveGameId(String id) async {
    isLoadingProfile.value = true;
    activeGameId = id;
    isLoadingProfile.value = false;
  }

  changeCoin(int value) {
    myData.value = myData.value!.copyWith(coin: myData.value!.coin + value);
  }

  changeProfile(int index) {
    if (myData.value!.coin < 50 && myData.value!.image != 0) {
      DialogComponent().showToast(label: AppTexts.notEnoughCoin.tr);
      return;
    }
    if (index == myData.value!.image) {
      DialogComponent().showToast(label: AppTexts.error.tr);
      return;
    }
    if (myData.value!.image == 0) {
      myData.value = myData.value!.copyWith(image: index);
    } else {
      myData.value =
          myData.value!.copyWith(image: index, coin: myData.value!.coin - 50);
    }
    globalRepo.changeProfile(image: index);
    Get.closeAllBottomSheets();
    DialogComponent().showToast(label: AppTexts.avatarChanged.tr);
  }

  changeUsername(String username) {
    if (myData.value!.coin < 75) {
      Get.closeAllBottomSheets();
      DialogComponent().showToast(label: AppTexts.notEnoughCoin.tr);
      return;
    }
    if (username == Get.find<GlobalController>().myData.value!.name) {
      DialogComponent().showToast(label: AppTexts.error.tr);
      return;
    }
    myData.value =
        myData.value!.copyWith(name: username, coin: myData.value!.coin - 75);
    globalRepo.changeUsername(username: username);
    Get.closeAllBottomSheets();
    DialogComponent().showToast(label: AppTexts.nameChanged.tr);
  }

  Future<void> finishGame() async {
    isLoadingProfile.value = true;
    activeGameId = null;
    isLoadingProfile.value = false;
    fetchUserData();
    Get.find<SoundPlayerComponent>().stopMusic();
  }

  void changeLanguegue() {
    if ((Get.locale ?? const Locale('en')).languageCode == 'en') {
      Get.updateLocale(const Locale('fa'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  void changeLetPlayMusic(bool value) async {
    String result = "0";
    if (value) {
      result = "1";
    }
    await globalRepo.setDataOnStorage(
        key: StorageKeys.gameMusic, value: result);
  }

  Future<void> removeData() async {
    token.value = null;
    userId = null;
    activeGameId = null;
    await globalRepo.logoutRemoveData();
  }

  @override
  void onInit() async {
    checkLoginStatus();
    super.onInit();
  }
}
