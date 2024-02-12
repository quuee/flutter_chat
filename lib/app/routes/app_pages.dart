import 'package:flutter_chat/app/modules/contacts/views/contact_simple_view.dart';
import 'package:flutter_chat/app/modules/login/bindings/LoginBinding.dart';
import 'package:flutter_chat/app/modules/login/views/login_view.dart';
import 'package:flutter_chat/app/modules/splash/bindings/splash_bindings.dart';
import 'package:flutter_chat/app/modules/splash/views/splash_view.dart';
import 'package:flutter_chat/app/modules/talks/controllers/chat_controller.dart';
import 'package:flutter_chat/app/modules/talks/views/chat_view.dart';
import 'package:get/get.dart';

import '/app/modules/main/views/main_view.dart';
import '/app/modules/main/bindings/main_binding.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_SIMPLE,
      page: () => ContactSimple(),
    ),
    GetPage(
      name: _Paths.TOCHAT,
      page: () => ChatView(),
      binding: BindingsBuilder((){Get.lazyPut(() => ChatController());})
    ),

  ];
}
