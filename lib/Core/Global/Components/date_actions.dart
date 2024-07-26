// import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateActionsComponent {
  final DateTime? date;

  DateActionsComponent({
    required this.date,
  });

  // String toJalali() {
  //   return Jalali.fromDateTime(date ?? DateTime.now()).formatMediumDate();
  // }

  static String formatSecondsToMinutes(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }
}
