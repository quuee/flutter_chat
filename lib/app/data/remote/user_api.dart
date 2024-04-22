
import 'package:dio/dio.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/network/dio_util.dart';
import 'package:flutter_chat/flavors/build_config.dart';

class UserApi {

  final logger = BuildConfig.instance.config.logger;

  static Future<ApiResult?> accountLogin(
      String account, String password) async {
    Map<String, dynamic> map = {};
    map['account'] = account;
    map['password'] = password;
    var op = Options(
        contentType: Headers.jsonContentType,
        method: DioUtil.post);
    try {

      Response response = await DioUtil.instance.request('/generate/login', data: map,options: op);
      return ApiResult.fromJson(response.data);

    } on DioException catch (e) {

      return null;
    }
  }

  static Future<ApiResult?> loadContacts(int userId) async {

    Map<String, dynamic> map = {};
    map['userId'] = userId;
    var op = Options(
        contentType: Headers.jsonContentType,
        method: DioUtil.get);
    try {

      Response response =  await DioUtil().request('/contact/list', params: map,options: op);
      return ApiResult.fromJson(response.data);
    } on DioException catch (e) {

      return null;
    }
  }

  static Future<ApiResult?> oneContact(int contactId) async {

    Map<String, dynamic> map = {};
    map['contactId'] = contactId;
    var op = Options(
        contentType: Headers.jsonContentType,
        method: DioUtil.get);
    try {

      Response response =  await DioUtil().request('/contact/one', params: map,options: op);
      return ApiResult.fromJson(response.data);
    } on DioException catch (e) {

      return null;
    }
  }
}