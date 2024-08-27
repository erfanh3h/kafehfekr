import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Core/global_repository.dart';
import 'package:kafehfekr/Core/Network/queue_socket.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Routes/app_routes.dart';
import 'package:refreshed/refreshed.dart';

// import '../Core/global_repository.dart';

class GlobalController extends BaseController {
  // final AuthRepository authRepo;
  final GlobalRepository globalRepo;

  ThemeMode currentTheme = ThemeMode.light;

  RxBool isQueueActive = RxBool(false);
  RxString activeQueueType = RxString('');

  PageController pgCtrl = PageController(initialPage: 2);
  RxInt selectedPage = RxInt(2);
  TextEditingController idController = TextEditingController(text: "1");
  TextEditingController gameIdController =
      TextEditingController(text: "gameId");

  String? userId;

  RxBool isLoadingProfile = RxBool(true);

  GlobalController({required this.globalRepo});

  changePage(int page) {
    selectedPage.value = page;
    pgCtrl.jumpToPage(page);
  }

  void checkLoginStatus() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (userId != null) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.offAllNamed(AppRoutes.entry);
      }
    });
  }

  Future<void> fetchUserData() async {
    isLoadingProfile.value = true;
    final result = await globalRepo.getDataFromStorage(key: StorageKeys.userId);
    if (result != null) {
      userId = result;
    }
    isLoadingProfile.value = false;
  }

  Future<void> setUserData(String data) async {
    isLoadingProfile.value = true;
    await globalRepo.setDataOnStorage(key: StorageKeys.userId, value: data);
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
      print("stop first");
      return;
    }
    Get.put(QueueSocketManager());
    Get.find<QueueSocketManager>().initSocket(
      commandHandler: queueCommandHandler,
      gameType: gameType,
      myId: idController.text,
    );
    isQueueActive.value = true;
    activeQueueType.value = gameType;
  }

  void queueCommandHandler(dynamic data) {
    final commandId = data['id'];
    switch (commandId) {
      case GameCommands.startGame:
        Future.delayed(const Duration(seconds: 3)).then((_) {
          Get.toNamed('/${activeQueueType.value}',
              arguments: data['data']['game_id']);
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
    activeQueueType.value = "";
  }

  @override
  void onInit() async {
    await fetchUserData();
    // if (_userId.value != null) {
    //   _userEmail.value = await globalRepo.getUserEmail();
    // }
    super.onInit();
  }
}
