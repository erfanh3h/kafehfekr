import 'package:refreshed/refreshed.dart';

abstract class BaseController extends GetxController {
  // late StreamSubscription<InternetConnectionStatus> _connectionListener;

  RxBool isPageLoading = RxBool(false);
  RxBool isPageLoadingMore = RxBool(false);

  showLoading() => isPageLoading.value = true;
  hideLoading() => isPageLoading.value = false;
}
