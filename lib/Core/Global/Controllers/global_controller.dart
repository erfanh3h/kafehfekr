import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Core/Network/queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

// import '../Core/global_repository.dart';

class GlobalController extends BaseController {
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  RxBool isQueueActive = RxBool(false);
  RxBool isGameLoading = RxBool(false);
  RxString activeQueueType = RxString('');

  PageController pgCtrl = PageController(initialPage: 2);
  RxInt selectedPage = RxInt(2);
  TextEditingController gameIdController =
      TextEditingController(text: "gameId");

  String? userId;
  String? token;
  String? activeGameId;
  String? activeGameType;

  RxBool isLoadingProfile = RxBool(true);

  GlobalController({required this.globalRepo});

  changePage(int page) {
    selectedPage.value = page;
    pgCtrl.jumpToPage(page);
  }

  void checkLoginStatus() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (token != null) {
        Get.offAllNamed(AppRoutes.main);
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          if (activeGameId != null) {
            Get.toNamed('/$activeGameType', arguments: activeGameId);
          }
        });
      } else {
        Get.offAllNamed(AppRoutes.auth);
      }
    });
  }

  Future<void> fetchUserData() async {
    // await globalRepo.logoutRemoveData();
    isLoadingProfile.value = true;
    final userIdData =
        await globalRepo.getDataFromStorage(key: StorageKeys.userId);
    if (userIdData != null) {
      userId = userIdData;
    }
    final tokenData =
        await globalRepo.getDataFromStorage(key: StorageKeys.token);
    if (tokenData != null) {
      token = tokenData;
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
    isLoadingProfile.value = false;
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

  Future<void> finishGame() async {
    isLoadingProfile.value = true;
    await globalRepo.removeDataFromStorage(key: StorageKeys.gameId);
    await globalRepo.removeDataFromStorage(key: StorageKeys.gameType);
    activeGameId = null;
    activeGameType = null;
    isLoadingProfile.value = false;
  }

  void changeLanguegue() {
    if ((Get.locale ?? const Locale('en')).languageCode == 'en') {
      Get.updateLocale(const Locale('fa'));
    } else {
      Get.updateLocale(const Locale('en'));
    }
  }

  void startQueue(String gameType) {
    if (isQueueActive.value) {
      DialogComponent().showToast(label: AppTexts.stopPrevoiusQueue.tr);
      return;
    }
    Get.put(QueueSocketManager());
    Get.find<QueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      gameType: gameType,
      myId: userId!,
    );
    isQueueActive.value = true;
    activeQueueType.value = gameType;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        isGameLoading.value = true;
        final String gameId = data['data']['game_id'];
        final String gameType = activeQueueType.value;
        setActiveGameId(gameId, gameType);
        Get.find<SoundPlayerComponent>()
            .playGameSound(GameSoundTypes.queueFinded);
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
    isGameLoading.value = false;
    activeQueueType.value = "";
  }

  @override
  void onInit() async {
    await fetchUserData();
    super.onInit();
  }
}
