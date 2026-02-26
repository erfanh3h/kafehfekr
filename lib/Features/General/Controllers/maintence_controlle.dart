import 'dart:io';

import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:refreshed/refreshed.dart';

class MaintenceController extends BaseController {
  late String fromNow;
  void onTap() {
    exit(0);
  }

  @override
  void onInit() {
    DateTime date = Get.arguments;
    // fromNow = date.difference(DateTime.now()).toString().split(".")[0];
    fromNow = date.hour.toString();
    super.onInit();
  }
}
