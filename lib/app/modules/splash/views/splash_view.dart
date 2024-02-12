import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.toNext();

    return Material(
      child: Center(
        child: Text('splash'),
      ),
    );
  }
}
