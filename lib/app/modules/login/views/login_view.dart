import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/values/app_colors.dart';
import 'package:flutter_chat/app/data/local/preference/preference_manager.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/model/user_do.dart';
import 'package:flutter_chat/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends GetView<LoginController> {
  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;
  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80), //距离顶部距离
            buildTopWidget(), //设置登陆欢迎
            const SizedBox(height: 20), //距离上一个View距离
            buildAccountInput(),
            const SizedBox(
              height: 10,
            ), //距离上一个View距离
            // buildPrivacyWidget(), //隐私政策
            const SizedBox(
              height: 10,
            ), //距离上一个View距离
            buildLoginButton(), //登陆按钮
          ],
        ),
      ),
    );
  }

  Widget buildTopWidget() {
    return const Text(
      '欢迎登录',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
    );
  }

  buildAccountInput() {
    return Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            TextFormField(
              autofocus: false,
              controller: controller.accountController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  hintText: "用户名或邮箱",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                  labelText: "密码",
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  hintText: "登录密码",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ));
  }

  //登陆按钮
  Widget buildLoginButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (!controller.loginFormKey.currentState!.validate()) {
              Fluttertoast.showToast(msg:'输入错误');
              return;
            }
            ApiResult? result = await controller.accountLogin();
            if(result?.code == 0){

              var userDO = UserDO.fromJson(result?.data);

              _preferenceManager.setString(PreferenceManager.keyToken,userDO.token );
              _preferenceManager.setString(PreferenceManager.userDO,userDO.toJsonString());
              Fluttertoast.showToast(msg:'登录成功');
              Get.offNamed(Routes.MAIN);
            }else{

            }

          },
          child: Text(
            '登录',
            style: TextStyle(color: AppColors.textColorTag),
          ),
        ));
  }

  //隐私协议
  // Widget buildPrivacyWidget() {
  //   return Row(
  //     children: [
  //       Obx(()=>Checkbox(value: controller.isChecked.value, onChanged: (value) =>controller.changeChecked(value!))),
  //       Text('同意', style: TextStyle(fontSize: 14)),
  //       Text('<服务协议>', style: TextStyle(fontSize: 14, color: Colors.blue)),
  //       Text('<隐私政策>', style: TextStyle(fontSize: 14, color: Colors.blue))
  //     ],
  //   );
  // }
}
