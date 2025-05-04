import 'dart:async';

import 'package:refreshed/refreshed.dart';

class TimerCompanent extends GetxController {
  Timer? _timer;
  final RxDouble _start = RxDouble(0);
  RxString timerLabel = RxString('');
  RxBool isCounting = RxBool(false);
  RxBool isPaused = RxBool(false);
  RxDouble percent = RxDouble(0);
  // end function run when timer fully completed
  void startTimer(int? timerDuration, {Function? endFunction}) {
    if (_timer != null) _timer!.cancel();

    _start.value = (timerDuration ?? 0).toDouble();
    timerLabel.value = _start.toInt().toString();
    isCounting.value = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start.value == 0) {
          timer.cancel();
          _start.value = 0;
          timerLabel.value = _start.toInt().toString();
          percent.value = _start.value;
          isCounting.value = false;
          try {
            endFunction!();
          } catch (_) {}
        } else if (isPaused.value) {
        } else {
          _start.value = _start.value - 1;
          timerLabel.value = _start.toInt().toString();
          // timerLabel.value = _start.value.toStringAsFixed(1);
          percent.value = _start.value / (timerDuration ?? 1).toDouble();
          update();
          // timerLabel.value =
          //     DateActionsComponent.formatSecondsToMinutes(_start.value.toInt());
        }
      },
    );
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _start.value = 0;
      timerLabel.value = "";
      percent.value = 0;
      isCounting.value = false;
      // timerLabel.value =
      //     DateActionsComponent.formatSecondsToMinutes(_start.value);
    }
  }

  // void pauseTimer() => isPaused.value = true;
  // void resumeTimer() => isPaused.value = false;

  @override
  void dispose() {
    try {
      _timer!.cancel();
    } catch (_) {}
    super.dispose();
  }
}
