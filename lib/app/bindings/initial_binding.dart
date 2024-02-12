import 'package:flutter_chat/app/core/permission_controller.dart';
import 'package:get/get.dart';

import 'local_source_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {

    LocalSourceBindings().dependencies();
    Get.put<PermissionController>(PermissionController());

  }
}
