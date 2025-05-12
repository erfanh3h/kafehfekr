import 'dart:math';

import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Core/Resources/persian_words.dart';
import 'package:kafehfekr/Games/Spy/Models/mafia_user_model.dart';
import 'package:refreshed/refreshed.dart';

class SpyOfflineController extends BaseOfflineGameController {
  int playersCount = 10;
  int spiesCount = 2;
  int gameMin = 5;
  RxBool isGamePhase = RxBool(false);

  RxInt showerCounter = RxInt(0);
  RxBool showRole = RxBool(false);

  RxString gameText = RxString("");

  RxList<SpyUserModel> users = RxList([]);

  RxBool isTimerCounting = RxBool(false);

  initGame() {
    final random = Random();
    final textIndex = random.nextInt(persianWords.length);
    gameText.value = persianWords[textIndex];
    List<int> numbers = List.generate(playersCount, (index) => index + 1);
    numbers.shuffle(random);
    List<int> selectedSpies = numbers.take(spiesCount).toList();
    for (var i = 1; i <= playersCount; i++) {
      SpyUserModel newUser = SpyUserModel();
      newUser.changeUsername('بازیکن $i');
      if (selectedSpies.contains(i)) {
        newUser.changeisSpy();
      }
      users.add(newUser);
    }
  }

  startGame() {
    Get.find<TimerCompanent>()
        .startTimer(gameMin * 5, endFunction: showWinSpies);
    isGamePhase.value = true;
    isTimerCounting.value = true;
  }

  triggerTimerStatus() {
    if (isTimerCounting.value) {
      Get.find<TimerCompanent>().pauseTimer();
      isTimerCounting.value = false;
    } else {
      Get.find<TimerCompanent>().resumeTimer();
      isTimerCounting.value = true;
    }
  }

  onNextShower() {
    if (showerCounter.value == playersCount - 1) {
      startGame();
      return;
    }
    showRole.value = false;
    showerCounter += 1;
  }

  onChangeShowRole() {
    showRole.value = !showRole.value;
  }

  showWinSpies() {
    DialogComponent()
        .showDialog(AppTexts.gameFinished.tr, AppTexts.spiesWin.tr);
    resetGame();
  }

  @override
  resetGame() {
    Get.find<TimerCompanent>().stopTimer();
    users.clear();
    isGamePhase.value = false;
    isTimerCounting.value = false;
    showerCounter.value = 0;
    gameText.value = "";
    initGame();
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      playersCount = Get.arguments[0];
      spiesCount = Get.arguments[1];
      gameMin = Get.arguments[2];
    }
    gameType = OfflineGameTypes.Spy;
    initGame();
  }

  @override
  void onClose() {
    super.onClose();
    Get.find<TimerCompanent>().stopTimer();
  }
}
