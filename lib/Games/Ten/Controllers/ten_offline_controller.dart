import 'dart:math';

import 'package:function_tree/function_tree.dart';
import 'package:kafehfekr/Core/Base/base_offline_game_controller.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Games/Ten/Models/numbers.dart';
import 'package:refreshed/refreshed.dart';

class TenOfflineController extends BaseOfflineGameController {
  RxList<RxString> operators = RxList();
  RxList<RxInt> numbers = RxList();

  RxList<RxString> operatorValues = RxList();
  RxList<RxInt> numberValues = RxList();

  RxBool letSendResult = RxBool(false);
  RxDouble result = RxDouble(0);

  List<int> currentNumbers = [];

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

  onOperatorRemove(int index) {
    if (isGameFinished.value) {
      return;
    }
    operatorValues[index].value = "";
    calculateResult();
  }

  onOperatorAccept(String value, int index) {
    if (isGameFinished.value) {
      return;
    }
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
    if (isGameFinished.value) {
      return;
    }
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
    if (isGameFinished.value) {
      return;
    }
    if (letSendResult.value) {
      isGameFinished.value = true;
      showInteraction(
          sound: GameSoundTypes.tapWrong, text: AppTexts.youWinGame.tr);
    } else {
      showInteraction(
          sound: GameSoundTypes.tapWrong, text: AppTexts.wrongAnswer.tr);
    }
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

  initNumbers() {
    currentNumbers = tenNumberSets[Random().nextInt(tenNumberSets.length)];
    numbers.add(RxInt(currentNumbers[0]));
    numbers.add(RxInt(currentNumbers[1]));
    numbers.add(RxInt(currentNumbers[2]));
    numbers.add(RxInt(currentNumbers[3]));
    showInteraction(sound: GameSoundTypes.startGame);
  }

  @override
  resetGame() {
    operators.clear();
    numbers.clear();
    operatorValues.clear();
    numberValues.clear();
    letSendResult.value = false;
    result.value = 0;
    currentNumbers.clear();
    initNumbers();
    addOperators();
    addNumbers();
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.Ten;
    initNumbers();
    addOperators();
    addNumbers();
  }
}
