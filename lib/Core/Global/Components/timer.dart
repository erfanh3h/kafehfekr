import 'dart:async';

import 'package:refreshed/refreshed.dart';

class TimerCompanent extends GetxController {
  Timer? _timer;
  final RxDouble _start = RxDouble(0);
  RxString timerLabel = RxString('');
  RxBool isCounting = RxBool(false);
  RxDouble percent = RxDouble(0);
  // end function run when timer fully completed
  void startTimer(int? timerDuration, {Function? endFunction}) {
    pauseTimer();

    _start.value = (timerDuration ?? 0).toDouble();

    isCounting.value = true;
    const oneSec = Duration(milliseconds: 100);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < .1) {
          timer.cancel();
          _start.value = 0;
          timerLabel.value = _start.toInt().toString();
          percent.value = _start.value;
          isCounting.value = false;
          try {
            endFunction!();
          } catch (_) {}
        } else {
          _start.value = _start.value - .1;
          timerLabel.value = _start.toInt().toString();
          percent.value = _start.value / (timerDuration ?? 1).toDouble();
          // timerLabel.value =
          //     DateActionsComponent.formatSecondsToMinutes(_start.value.toInt());
        }
      },
    );
  }

  void pauseTimer() {
    if (_timer != null) _timer!.cancel();
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

  void unpauseTimer({Function? endFunction}) =>
      startTimer(_start.value.toInt(), endFunction: endFunction);

  @override
  void dispose() {
    try {
      _timer!.cancel();
    } catch (_) {}
    super.dispose();
  }
}
