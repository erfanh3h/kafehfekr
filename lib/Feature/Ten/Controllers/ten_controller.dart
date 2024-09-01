import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

class TenController extends BaseGameController {
  RxList<RxString> operators = RxList();
  RxList<RxInt> numbers = RxList();

  RxList<RxString> operatorValues = RxList();
  RxList<RxInt> numberValues = RxList();

  int maxRound = GameRoundCounts.tenRoundCount;

  RxBool letSendResult = RxBool(false);
  RxDouble result = RxDouble(0);

  List<int> currentNumbers = [];

  @override
  void currentTurnFunction(Map data) {
    List<int> listNumbers = List<int>.from(data['data']);
    currentNumbers = listNumbers;
    setNumbers();
    showInteraction(sound: GameSoundTypes.startGame);
    changetimerValue(GameWaitTimes.tenRoundTime);
  }

  @override
  void newRoundFunction(Map data) {
    int newRound = data['data'];
    currentRound.value = newRound;
    resetValues();
  }

  @override
  void finishRoundFunction(Map data) {
    Map newData = data['data'];
    Get.find<TimerCompanent>().stopTimer();
    int roundWinner = newData['Winner'] ?? 0;
    if (roundWinner == 1) {
      player1Score.value += 1;
    } else if (roundWinner == 2) {
      player2Score.value += 1;
    }
    if (roundWinner == myGameId) {
      showInteraction(sound: GameSoundTypes.win);
    } else {
      showInteraction(sound: GameSoundTypes.lose);
    }
    FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
    changetimerValue(GameWaitTimes.tenSleepRoundTime);
  }

  bool checkOperatorsHaveValue(String value) {
    bool result = false;
    for (var dataRaw in operatorValues) {
      if (dataRaw.value.contains(value)) {
        result = true;
        break;
      }
    }
    return result;
  }

  @override
  void reconnectDataFuntcion(Map data) {
    super.reconnectDataFuntcion(data);
    Map newData = data['data'];
    Map gameData = newData['game_data'];
    Map timerData = newData['timer_data'];
    List<int> listNumbers = List<int>.from(gameData['current_numbers']);
    currentNumbers = listNumbers;
    setNumbers();
    currentRound.value = gameData['current_round'];
    player1Score.value = gameData['scores'][0];
    player2Score.value = gameData['scores'][1];
    final int time = GameWaitTimes.tenRoundTime - timerData['time'] as int;
    changetimerValue(time.clamp(0, time));
  }

  @override
  Color returnTimerColor() {
    return AppColors.darkColor;
  }

  onOperatorRemove(int index) {
    operatorValues[index].value = "";
    calculateResult();
  }

  onOperatorAccept(String value, int index) {
    if (index == 4 && value != ')') {
      return;
    }
    if (index == 0 && value != '(' && value != '-') {
      return;
    }
    if (value == ')') {
      if (!checkOperatorsHaveValue(value)) {
        operatorValues[index].value = value;
      }
    } else if (value == '(') {
      if (!checkOperatorsHaveValue(value)) {
        operatorValues[index].value = value;
      }
    } else if (value == 'x' || value == '÷') {
      if (index != 0 && index != 4) {
        if (operatorValues[index].value == ')') {
          operatorValues[index].value = ')$value';
        } else if (operatorValues[index].value == '(') {
          operatorValues[index].value = '$value(';
        } else {
          operatorValues[index].value = value;
        }
      }
    } else {
      if (operatorValues[index].value == ')') {
        operatorValues[index].value = ')$value';
      } else if (operatorValues[index].value == '(') {
        operatorValues[index].value = '$value(';
      } else {
        operatorValues[index].value = value;
      }
    }
    calculateResult();
  }

  bool checkRepeatedNumberCanEnter(int number) {
    int repeatCount = 0;
    for (var num in currentNumbers) {
      if (num == number) {
        repeatCount += 1;
      }
    }
    int numbersRepeatCount = 0;

    for (var num in numberValues) {
      if (num.value == number) {
        numbersRepeatCount += 1;
      }
    }
    if (numbersRepeatCount < repeatCount) {
      return true;
    }
    return false;
  }

  bool checkNumbersHaveValue(int value) {
    bool result = false;
    for (var dataRaw in numberValues) {
      if (dataRaw.value == value) {
        if (!checkRepeatedNumberCanEnter(value)) {
          result = true;
          break;
        }
      }
    }
    return result;
  }

  onNumberRemove(int index) {
    numberValues[index].value = -1;
    calculateResult();
  }

  onNumberAccept(int value, int index) {
    if (!checkNumbersHaveValue(value)) {
      numberValues[index].value = value;
    }
    calculateResult();
  }

  String calculateExpression() {
    String expression = "";
    if (operatorValues[0].value != "") {
      expression +=
          operatorValues[0].value.replaceAll("x", "*").replaceAll('÷', "/");
    }
    if (numberValues[0].value != -1) {
      expression += numberValues[0].value.toString();
    }
    if (operatorValues[1].value != "") {
      expression +=
          operatorValues[1].value.replaceAll("x", "*").replaceAll('÷', "/");
    } else {
      return expression;
    }
    if (numberValues[1].value != -1) {
      expression += numberValues[1].value.toString();
    }
    if (operatorValues[2].value != "") {
      expression +=
          operatorValues[2].value.replaceAll("x", "*").replaceAll('÷', "/");
    } else {
      return expression;
    }
    if (numberValues[2].value != -1) {
      expression += numberValues[2].value.toString();
    }
    if (operatorValues[3].value != "") {
      expression +=
          operatorValues[3].value.replaceAll("x", "*").replaceAll('÷', "/");
    } else {
      return expression;
    }
    if (numberValues[3].value != -1) {
      expression += numberValues[3].value.toString();
    }
    if (operatorValues[4].value != "") {
      expression +=
          operatorValues[4].value.replaceAll("x", "*").replaceAll('÷', "/");
    }
    return expression;
  }

  calculateResult() {
    final String expression = calculateExpression();
    try {
      result.value = expression.interpret().toDouble();
    } catch (_) {}
    for (var dataRaw in numberValues) {
      if (dataRaw.value == -1) {
        letSendResult.value = false;
        return;
      }
    }
    if (result.value == 10) {
      letSendResult.value = true;
    } else {
      letSendResult.value = false;
    }
  }

  sendResult() {
    if (!letSendResult.value) {
      return;
    }
    sendCommand({"id": GameCommands.solve});
  }

  void resetValues() {
    for (var i = 0; i < operatorValues.length; i++) {
      operatorValues[i].value = "";
    }
    for (var i = 0; i < numberValues.length; i++) {
      numberValues[i].value = -1;
    }
    result.value = 0;
  }

  setNumbers() {
    numbers[0].value = currentNumbers[0];
    numbers[1].value = currentNumbers[1];
    numbers[2].value = currentNumbers[2];
    numbers[3].value = currentNumbers[3];
  }

  addOperators() {
    operators.add(RxString('('));
    operators.add(RxString('+'));
    operators.add(RxString('-'));
    operators.add(RxString('x'));
    operators.add(RxString('÷'));
    operators.add(RxString(')'));
    operatorValues.add(RxString(''));
    operatorValues.add(RxString(''));
    operatorValues.add(RxString(''));
    operatorValues.add(RxString(''));
    operatorValues.add(RxString(''));
  }

  addNumbers() {
    numbers.add(RxInt(-1));
    numbers.add(RxInt(-1));
    numbers.add(RxInt(-1));
    numbers.add(RxInt(-1));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Ten;
    addOperators();
    addNumbers();
  }
}
