

import 'package:flutter_chat/app/data/global/global_value_controller.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:get/get.dart';


class MeController extends GetxController{

  final GlobalValueController _globalValueController =
  Get.find<GlobalValueController>();

  UserDO? get currentUser => _globalValueController.currentUser;

  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());

  deleteToken(){
    _preferenceManager.remove(PreferenceManager.keyToken);
  }
}