// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter_poolakey/flutter_poolakey.dart';
import 'package:kafehfekr/Core/Global/Components/dialog.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:kafehfekr/Core/Resources/app_texts.dart';
// import 'package:myket_iap/myket_iap.dart';
// import 'package:myket_iap/util/iab_result.dart';
// import 'package:myket_iap/util/purchase.dart';
import 'package:refreshed/refreshed.dart';

class PurchaseComponent {
  init() async {
    if (marketType == MarketTypes.Bazaar) {
      final connected = await FlutterPoolakey.connect(
        bazaarRSA,
        onDisconnected: () => log("Poolakey disconnected!"),
      );
    } else if (marketType == MarketTypes.Myket) {
      // IabResult? result =
      //     await MyketIAP.init(rsaKey: myketRSA, enableDebugLogging: true);
    }
  }

  Future<(bool, String?)> purchase(String id, String userId) async {
    if (marketType == MarketTypes.Bazaar) {
      try {
      // return (true, "24261909103423");
      PurchaseInfo? response = await FlutterPoolakey.purchase(
        id,
        payload: {'user_id': userId}.toString(),
      );
      if (response.purchaseToken != "") {
        await FlutterPoolakey.consume(response.purchaseToken);
        return (true, response.purchaseToken);
      }
      return (false, null);
      } catch (_) {
          DialogComponent().showToast(label: AppTexts.purchaseCanceled.tr);
          return (false, null);
      }
    } else if (marketType == MarketTypes.Myket) {
      // Map result = await MyketIAP.launchPurchaseFlow(
      //   sku: id,
      //   payload: {'user_id': userId}.toString(),
      // );
      // // 6 for not found
      // try {
      //   final res = result['result'] as IabResult;
      //   if (res.mResponse == -1005) {
      //     DialogComponent().showToast(label: AppTexts.purchaseCanceled.tr);
      //     return (false, null);
      //   }
      //   if (res.mResponse == 0) {
      //     final purchase = result['purchase'] as Purchase;
      //     Map re = await MyketIAP.consume(purchase: purchase);
      //     return (true, purchase.mToken);
      //   }
      // } catch (_) {}
    }
    return (false, null);
  }

  dispose() async {
    if (marketType == MarketTypes.Bazaar) {
    } else if (marketType == MarketTypes.Myket) {
      // await MyketIAP.dispose();
    }
  }
}
