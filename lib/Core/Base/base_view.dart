import 'package:flutter/material.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_loading_widget.dart';
import 'package:kafehfekr/Core/Global/Widgets/global_wait_widget.dart';
import 'package:refreshed/refreshed.dart';

import '../Resources/app_colors.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends StatelessWidget {
  const BaseView({super.key});

  final String? tag = null;

  T get controller => Get.find<T>(tag: tag);

  AppBar? appBar(final BuildContext context) {
    return null;
  }

  // GlobalKey<ScaffoldState>? setScaffoldKey({GlobalKey<ScaffoldState>? value}) {
  //   GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  //   if (value != null) {
  //     globalKey = value;
  //   }
  //   return globalKey;
  // }

  // You can Override it
  bool safeAreaState() {
    return false;
  }

  String? backgroundImage() {
    return null;
  }

  // You can Override it
  bool resizeToAvoidBottomInset() {
    return false;
  }

  // this use to determine we need will pop scope or not(in ios on will pop scope won't work)
  bool setWillPopScope() {
    return true;
  }

  bool preventPop() {
    return true;
  }

  // this use to separate type of bodies
  bool isSingleBody() {
    return true;
  }

  bool extendBodyBehindNavigationBar() {
    return false;
  }

  bool extendBodyBehindAppBar() {
    return false;
  }

  Widget body(final BuildContext context);

  Widget tabletBody(final BuildContext context) => body(context);

  Widget webBody(final BuildContext context) => body(context);

  @override
  Widget build(final BuildContext context) {
    return pageContent(context);
  }

  Widget pageScaffold(final BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: pageBackgroundColor(context),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        // key: setScaffoldKey(),
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: floatingActionButtonLocation(),
        extendBodyBehindAppBar: extendBodyBehindAppBar(),
        extendBody: extendBodyBehindNavigationBar(),
        body: Container(
          decoration: backgroundImage() != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage()!),
                    fit: BoxFit.fill,
                  ),
                )
              : null,
          child: controller.isPageLoading.value
              ? const SafeArea(
                  child: GlobalLoadingWidget(color: AppColors.lightColor),
                )
              : safeAreaState()
                  ? SafeArea(child: body(context))
                  : body(context),
        ),
        drawer: drawer(),
        endDrawer: endDrawer(),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget pageContent(final BuildContext context) {
    return setWillPopScope()
        ? BackButtonListener(
            onBackButtonPressed: () {
              return Future.value(preventPop());
            },
            child: pageScaffold(context),
          )
        : pageScaffold(context);
  }

  Widget showErrorSnackBar(final String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container(
      color: AppColors.background,
    );
  }

  Color pageBackgroundColor(BuildContext context) {
    return AppColors.darkColor;
  }

  Color statusBarColor() {
    return AppColors.transparent;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget? endDrawer() {
    return null;
  }

  Widget loadingWidget() {
    return const Center(
      child: GlobalWaitWidget(),
    );
  }

  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return FloatingActionButtonLocation.endFloat;
  }
}
