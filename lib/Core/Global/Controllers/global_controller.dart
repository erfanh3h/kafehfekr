import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Core/Global/Models/config_model.dart';
import 'package:kafehfekr/Core/Network/queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_history_model.dart';
import 'package:kafehfekr/Feature/Auth/Models/user_model.dart';
import 'package:refreshed/refreshed.dart';

// import '../Core/global_repository.dart';

class GlobalController extends BaseController {
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  RxBool isQueueActive = RxBool(false);
  RxBool isQueueLoading = RxBool(false);
  RxString activeQueueType = RxString('');

  PageController pgCtrl = PageController(initialPage: 2);
  RxInt selectedPage = RxInt(2);
  TextEditingController gameIdController =
      TextEditingController(text: "gameId");

  String? userId;
  String? token;
  String? activeGameId;
  String? activeGameType;

  Rx<UserModel?> myData = Rx(null);
  Rx<UserHistoryModel?> myHistoryData = Rx(null);
  RxBool isLoadingProfile = RxBool(true);
  RxBool isLoadingHistory = RxBool(false);

  RxBool errorGetData = RxBool(false);

  GlobalController({required this.globalRepo});

  changePage(int page) {
    selectedPage.value = page;
    pgCtrl.jumpToPage(page);
  }

  void checkLoginStatus() async {
    // await removeData();
    bool isConfigOk = await getConfigData();
    if (isConfigOk) {
      await fetchUserData();
      if (token != null) {
        if (myData.value!.name == "") {
          Get.offAllNamed(AppRoutes.username);
        } else {
          Get.offAllNamed(AppRoutes.main);
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            if (activeGameId != null) {
              Get.find<SoundPlayerComponent>().startPlayMusic(isGame: true);
              Get.toNamed('/$activeGameType', arguments: activeGameId);
            } else {
              Get.find<SoundPlayerComponent>().startPlayMusic(isGame: false);
            }
          });
        }
      } else {
        Get.offAllNamed(AppRoutes.auth);
      }
    }
  }

  Future<bool> getConfigData() async {
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
      errorGetData.value = true;
      return false;
    }
    {}
    return true;
  }

  Future<void> fetchUserData() async {
    isLoadingProfile.value = true;
    final tokenData =
        await globalRepo.getDataFromStorage(key: StorageKeys.token);
    if (tokenData != null) {
      token = tokenData;
      final dataResult = await globalRepo.getMyData();
      if (dataResult.resultData != null) {
        myData.value = dataResult.resultData!;
      }
      final userIdData =
          await globalRepo.getDataFromStorage(key: StorageKeys.userId);
      if (userIdData != null) {
        userId = userIdData;
      }
      final gameIdData =
          await globalRepo.getDataFromStorage(key: StorageKeys.gameId);
      if (gameIdData != null) {
        activeGameId = gameIdData;
      }
      final gameTypeData =
          await globalRepo.getDataFromStorage(key: StorageKeys.gameType);
      if (gameTypeData != null) {
        activeGameType = gameTypeData;
      }
    }
    isLoadingProfile.value = false;
  }

  Future<void> fetchMyHistoryData() async {
    isLoadingHistory.value = true;
    final dataResult = await globalRepo.getMyHistoryData();
    if (dataResult.resultData != null) {
      myHistoryData.value = dataResult.resultData!;
    }
    isLoadingHistory.value = false;
  }

  Future<void> setUserData(String newUserId, String newToken) async {
    isLoadingProfile.value = true;
    await globalRepo.setDataOnStorage(
        key: StorageKeys.userId, value: newUserId);
    await globalRepo.setDataOnStorage(key: StorageKeys.token, value: newToken);
    userId = newUserId;
    token = newToken;
    isLoadingProfile.value = false;
  }

  Future<void> setActiveGameId(String id, String type) async {
    isLoadingProfile.value = true;
    await globalRepo.setDataOnStorage(key: StorageKeys.gameId, value: id);
    await globalRepo.setDataOnStorage(key: StorageKeys.gameType, value: type);
    activeGameId = id;
    activeGameType = type;
    isLoadingProfile.value = false;
  }

  changeProfile(int index) {
    myData.value = myData.value!.copyWith(image: index);
    globalRepo.changeProfile(image: index);
  }

  Future<void> finishGame() async {
    isLoadingProfile.value = true;
    await globalRepo.removeDataFromStorage(key: StorageKeys.gameId);
    await globalRepo.removeDataFromStorage(key: StorageKeys.gameType);
    activeGameId = null;
    activeGameType = null;
    isLoadingProfile.value = false;
    fetchMyHistoryData();
    Get.find<SoundPlayerComponent>().startPlayMusic(isGame: false);
  }

  void changeLanguegue() {
    if ((Get.locale ?? const Locale('en')).languageCode == 'en') {
      Get.updateLocale(const Locale('fa'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  void onQueueStarted() {
    isQueueLoading.value = false;
  }

  void onQueueError() {
    stopQueue();
    DialogComponent().showToast(label: AppTexts.timeoutError.tr);
  }

  void startQueue(String gameType) {
    if (isQueueActive.value) {
      DialogComponent().showToast(label: AppTexts.stopPrevoiusQueue.tr);
      return;
    }
    isQueueActive.value = true;
    isQueueLoading.value = true;
    Get.put(QueueSocketManager());
    Get.find<QueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      gameType: gameType,
      myId: userId!,
      onQueueStart: onQueueStarted,
      onQueueError: onQueueError,
    );
    activeQueueType.value = gameType;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        isQueueActive.value = true;
        final String gameId = data['data']['game_id'];
        final String gameType = activeQueueType.value;
        setActiveGameId(gameId, gameType);
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.queueFinded);
        Get.find<SoundPlayerComponent>().startPlayMusic(isGame: true);
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Get.toNamed('/$gameType', arguments: gameId);
          stopQueue();
        });
        break;
      default:
    }
  }

  void stopQueue() {
    // Get.find<QueueSocketManager>().disconnect();
    Get.delete<QueueSocketManager>();
    isQueueActive.value = false;
    isQueueLoading.value = false;
    activeQueueType.value = "";
  }

  Future<void> removeData() async {
    token = null;
    userId = null;
    activeGameId = null;
    activeGameType = null;
    await globalRepo.logoutRemoveData();
  }

  @override
  void onInit() async {
    // await fetchUserData();
    super.onInit();
  }
}
