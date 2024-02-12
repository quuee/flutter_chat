
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
  
  @override
  void onReady() {
    super.onReady();
    toNext();
  }
  
  toNext() {

    Future.delayed(const Duration(milliseconds: 500), () async {

      print('==SplashController==');
      String token = await _preferenceManager.getString(PreferenceManager.keyToken);
      if(token == ''){
        Get.offNamed(Routes.LOGIN);
      }else{
        Get.offNamed(Routes.MAIN);
      }

    });
  }


}