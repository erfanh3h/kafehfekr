// import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateActionsComponent {
  // String toJalali() {
  //   return Jalali.fromDateTime(date ?? DateTime.now()).formatMediumDate();
  // }

  static String dateTimeToHourMin(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')} : ${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatSecondsToMinutes(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    final minuteStr = minutes.toString().padLeft(2, '0');
    final secondStr = seconds.toString().padLeft(2, '0');

    return '$minuteStr:$secondStr';
  }
}
