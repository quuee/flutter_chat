
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
        contentType: Headers.jsonContentType, method: DioUtil.post);
    try {
      var response = await DioUtil.instance
          .request('/generate/login', data: map, options: op);
      ApiResult apiResult = ApiResult.fromJson(response.data);
      return apiResult;
    } on DioException catch (e) {

      return null;
    }
  }

  static Future<ApiResult?> loadContacts(int userId) async {
    var op = Options(
        contentType: Headers.jsonContentType, method: DioUtil.get);
    Map<String, dynamic> map = {};
    map['userId'] = userId;
    try {
    var response = await DioUtil.instance
        .request('/contact/list', params: map, options: op);
    ApiResult apiResult = ApiResult.fromJson(response.data);
    return apiResult;
    } on DioException catch (e) {

      return null;
    }
  }
}