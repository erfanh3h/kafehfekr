import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:refreshed/refreshed.dart';

class StoreController extends BaseController {
  final GeneralRepository repo;

  RxBool canGetFreeCoin = RxBool(false);

  RxString remainTimeText = RxString("");
  getFreeCoin() async {
    if (!canGetFreeCoin.value) {
      return;
    }
    final result = await repo.getFreeCoin();
    if (result.resultData != null) {
      print(result.resultData);
    }
  }

  StoreController({required this.repo});

  checkCanGetFreeCoin() {
    final DateTime lastTimeChance =
        Get.find<GlobalController>().myData.value!.lastTimeChance;
    final DateTime possibleDate = DateTime(
        lastTimeChance.year,
        lastTimeChance.month,
        lastTimeChance.day,
        lastTimeChance.hour + 8,
        lastTimeChance.minute);
    final durationLeft = DateTime.now().difference(possibleDate);
    if (durationLeft.inHours >= 8) {
      canGetFreeCoin.value = true;
    } else {
      remainTimeText.value =
          "${durationLeft.inHours} : ${durationLeft.inMinutes} : 00";
      canGetFreeCoin.value = false;
    }
  }

  @override
  void onInit() {
    checkCanGetFreeCoin();
    super.onInit();
  }
}
