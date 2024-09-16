import 'package:kafehfekr/Core/Base/base_controller.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Components/purchase.dart';
import 'package:kafehfekr/Core/Global/Controllers/global_controller.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_icons.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
import 'package:kafehfekr/Feature/General/Core/general_repository.dart';
import 'package:refreshed/refreshed.dart';

class StoreController extends BaseController {
  final GeneralRepository repo;

  RxBool canGetFreeCoin = RxBool(false);

  RxInt remainTime = RxInt(0);

  RxBool isGettingCoin = RxBool(false);

  List<int> prices = [9900, 29900, 59900, 99000, 199000, 299000];
  List<int> counts = [50, 160, 330, 525, 1100, 1700];
  List<String> images = [
    GeneralIcons.store1,
    GeneralIcons.store2,
    GeneralIcons.store3,
    GeneralIcons.store4,
    GeneralIcons.store5,
    GeneralIcons.store6
  ];

  final PurchaseComponent purchaseComponent = PurchaseComponent();
  getFreeCoin() async {
    if (!canGetFreeCoin.value) {
      DialogComponent().showToast(label: AppTexts.notTimeYet.tr);
      return;
    }
    isGettingCoin.value = true;
    int coin = 0;
    final result = await repo.getFreeCoin();
    if (result.resultData != null) {
      coin = result.resultData!;
    }
    Future.delayed(const Duration(seconds: 3)).then((_) {
      isGettingCoin.value = false;
      DialogComponent().showIconicDialog(
        'سکه',
        'برنده ی $coin سکه شدی',
        GeneralIcons.coin,
        AppColors.goldenColor,
      );
      Get.find<GlobalController>().fetchUserData().then((_) {
        checkCanGetFreeCoin();
      });
    });
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
    if (durationLeft.inSeconds >= 1) {
      canGetFreeCoin.value = true;
    } else {
      remainTime.value = durationLeft.inSeconds;
      canGetFreeCoin.value = false;
    }
  }

  String indexToValue(int index) {
    if (index == 0 || index == 8) {
      return "4";
    }
    if (index == 1 || index == 7) {
      return "8";
    }
    if (index == 2 || index == 6) {
      return "12";
    }
    if (index == 3 || index == 5) {
      return "16";
    }
    return "20";
  }

  int productIdToValue(String id) {
    if (id == "1") {
      return 50;
    }
    if (id == "2") {
      return 160;
    }
    if (id == "3") {
      return 330;
    }
    if (id == "4") {
      return 525;
    }
    if (id == "5") {
      return 1100;
    }
    if (id == "6") {
      return 1700;
    }
    return 0;
  }

  purchaseItem(int index) async {
    final String productId = (index + 1).toString();
    final result = await purchaseComponent.purchase(
        productId, Get.find<GlobalController>().myData.value!.id);
    if (result.$1) {
      repo.purchase(
          productId: productId, marketType: marketType.name, token: result.$2!);
      final int coin = productIdToValue(productId);
      Get.find<GlobalController>().changeCoin(coin);
      DialogComponent().showIconicDialog(
        AppTexts.buyCoin.tr,
        '$coin سکه اضافه شد',
        GeneralIcons.coin,
        AppColors.goldenColor,
      );
    }
  }

  @override
  void onInit() async {
    checkCanGetFreeCoin();
    await purchaseComponent.init();
    super.onInit();
  }
}
