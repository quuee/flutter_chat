
import 'package:flutter/material.dart';
import 'package:flutter_chat/app/core/base/base_controller.dart';
import 'package:flutter_chat/app/data/remote/user_api.dart';
import 'package:flutter_chat/app/model/api_result.dart';


class LoginController extends BaseController{

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  final loginFormKey = GlobalKey<FormState>();

  Future<ApiResult?> accountLogin() async {

    ApiResult? result = await UserApi.accountLogin(accountController.text, passwordController.text);
    return result;
  }
}