import 'package:flutter_chat/app/core/permission_controller.dart';
import 'package:flutter_chat/app/network/websocket_provider.dart';
import 'package:get/get.dart';

import 'local_source_bindings.dart';

class InitialBinding implements Bindings {
  @override
  Future<void> dependencies() async {

    await LocalSourceBindings().dependencies();
    Get.put<PermissionController>(PermissionController());
    Get.put<WebSocketProvider>(WebSocketProvider(),permanent: true);//permanent: true 实例将在整个应用程序中保持活动状态,不会被释放

  }
}
