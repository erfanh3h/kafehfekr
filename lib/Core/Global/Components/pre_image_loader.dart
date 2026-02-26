import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Resources/app_images.dart';
import 'package:refreshed/get_navigation/get_navigation.dart';
import 'package:refreshed/state_manager.dart';

class PreImageLoader {
  static Future<void> loadImages() async {
    await precacheImage(
        const AssetImage(AppImages.background1), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.background2), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.dialog), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.dialog2), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.dialog3), Get.overlayContext!);
    await precacheImage(const AssetImage(AppImages.board), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.bilboard), Get.overlayContext!);
    await precacheImage(
        const AssetImage(AppImages.bilboard2), Get.overlayContext!);
  }
}
