import 'package:flutter_chat/app/modules/talks/controllers/conversation_controller.dart';
import 'package:flutter_chat/app/modules/contacts/controllers/contacts_controller.dart';
import 'package:flutter_chat/app/modules/explore/controllers/explore_controller.dart';
import 'package:flutter_chat/app/modules/me/controllers/me_controller.dart';
import 'package:get/get.dart';

import '/app/modules/main/controllers/main_controller.dart';


/// fenix 参数默认为 false，作用是当销毁时，会将依赖移除，但是下次 find 时又会重新创建依赖对象，但是如果在页面返回时会报错；
/// feni：true时在页面返回不会报错，因为重新创建了依赖对象
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
