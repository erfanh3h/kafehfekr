import 'package:function_tree/function_tree.dart';
import 'package:kafehfekr/Core/Base/base_game_controller.dart.dart';
import 'package:kafehfekr/Core/Global/Components/functions_library.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Global/Components/timer.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:refreshed/refreshed.dart';

class TenController extends BaseGameController {
  RxList<RxString> operators = RxList();
  RxList<RxInt> numbers = RxList();

  RxList<RxString> operatorValues = RxList();
  RxList<RxInt> numberValues = RxList();

  int maxRound = 3;

  @override
  void currentTurnFunction(Map data) {
    int turn = data['data'];
    currentTurn.value = turn;
    if (turn == myGameId) {
      canSelectPeace.value = true;
      Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.startTurn);
    } else {
      canSelectPeace.value = false;
    }
    changetimerValue(GameWaitTimes.tictactoeRoundTime);
  }

  @override
  void newRoundFunction(Map data) {
    int newRound = data['data'];
    currentRound.value = newRound;
    resetPeaces();
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
    FunctionsLibraryClass.showFinishRoundDialog(roundWinner, myGameId);
  }

  bool checkOperatorsHaveValue(String value) {
    bool result = false;
    for (var dataRaw in operatorValues) {
      if (dataRaw.value == value) {
        result = true;
        break;
      }
    }
    return result;
  }

  onOperatorRemove(int index) {
    operatorValues[index].value = "";
  }

  onOperatorAccept(String value, int index) {
    if (index == 4 && value != ')') {
      return;
    }
    if (index == 0 && value != '(') {
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
  }

  bool checkNumbersHaveValue(int value) {
    bool result = false;
    for (var dataRaw in numberValues) {
      if (dataRaw.value == value) {
        result = true;
        break;
      }
    }
    return result;
  }

  onNumberRemove(int index) {
    numberValues[index].value = -1;
  }

  onNumberAccept(int value, int index) {
    if (!checkNumbersHaveValue(value)) {
      numberValues[index].value = value;
    }
  }

  calculateResult() {
    final expressionsExample = [
      '-(2*4)-2+2',
      '(3 + 2)^3',
      '3 * pi / 4',
      '3 * sin(5 * pi / 6)',
      'e^(-1)'
    ];
    for (final expression in expressionsExample) {
      print("'$expression' -> ${expression.interpret()}");
    }
  }
  // @override
  // void onEachButtonTap(dynamic tappedPeace) {
  //   TicTacToePeaceModel peace = tappedPeace as TicTacToePeaceModel;
  //   if (!canSelectPeace.value) {
  //     Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
  //     return;
  //   }
  //   if (peace.selectedUser != null) {
  //     Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tapWrong);
  //     return;
  //   }
  //   canSelectPeace.value = false;
  //   sendCommand({"id": GameCommands.selectPeace, "data": peace.id});
  //   addPeaceStatus(peace.id, PeaceStatusTypes.isLoading);
  //   Get.find<SoundPlayerComponent>().playGameSound(GameSoundTypes.tap);
  // }

  void resetPeaces() {
    // for (var i = 0; i < peaces.length; i++) {
    //   peaces[i].value = peaces[i].value.resetPeace();
    // }
  }

  addPeaceStatus(int peaceId, PeaceStatusTypes status) {
    // peaces.value[peaceId].value =
    //     peaces.value[peaceId].value.addStatus(status: status);
  }

  removePeaceStatus(int peaceId, PeaceStatusTypes status) {
    // peaces.value[peaceId].value =
    //     peaces.value[peaceId].value.removeStatus(status: status);
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
    numbers.add(RxInt(1));
    numbers.add(RxInt(2));
    numbers.add(RxInt(3));
    numbers.add(RxInt(4));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
    numberValues.add(RxInt(-1));
  }

  @override
  void onInit() async {
    super.onInit();
    gameType = GameTypes.ten;
    addOperators();
    addNumbers();
  }
}
