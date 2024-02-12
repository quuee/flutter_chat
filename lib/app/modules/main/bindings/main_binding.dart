import 'package:flutter_chat/app/modules/talks/controllers/conversation_controller.dart';
import 'package:flutter_chat/app/modules/contacts/controllers/contacts_controller.dart';
import 'package:flutter_chat/app/modules/explore/controllers/explore_controller.dart';
import 'package:flutter_chat/app/modules/me/controllers/me_controller.dart';
import 'package:get/get.dart';

import '/app/modules/main/controllers/main_controller.dart';

/// 设置 permanent 为 true 后，返回 PageA 同样能获取到依赖对象，说明依赖并没有因为页面销毁而回收
/// fenix 参数默认为 false，作用是当销毁时，会将依赖移除，但是下次 find 时又会重新创建依赖对象。
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<ConversationController>(
          () => ConversationController(),
      fenix: true,
    );
    Get.lazyPut<ContactsController>(
          () => ContactsController(),
      fenix: true,
    );
    Get.lazyPut<ExploreController>(
          () => ExploreController(),
      fenix: true,
    );
    Get.lazyPut<MeController>(
          () => MeController(),
      fenix: true,
    );
  }
}
