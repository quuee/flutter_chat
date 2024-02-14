
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/app/core/model/page_state.dart';
import '/flavors/build_config.dart';

abstract class BaseController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  // AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  // final logoutController = false.obs;

  //Reload the page
  // final _refreshController = false.obs;

  // refreshPage(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  // final _messageController = ''.obs;

  // String get message => _messageController.value;

  // showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  // showErrorMessage(String msg) {
  //   _errorMessageController(msg);
  // }

  // final _successMessageController = ''.obs;

  // String get successMessage => _messageController.value;

  // showSuccessMessage(String msg) => _successMessageController(msg);


  // @override
  // void onClose() {
  //   _messageController.close();
  //   _refreshController.close();
  //   _pageSateController.close();
  //   super.onClose();
  // }
}
