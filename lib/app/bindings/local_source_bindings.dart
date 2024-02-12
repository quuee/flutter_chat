import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:get/get.dart';

import '/app/data/local/preference/preference_manager.dart';
import '/app/data/local/preference/preference_manager_impl.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );

    Get.lazyPut<WebSocketProvider>(
          () => WebSocketProvider(),
      tag: (WebSocketProvider).toString(),
      fenix: true,
    );
  }
}
