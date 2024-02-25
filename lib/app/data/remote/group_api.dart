
import 'package:dio/dio.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/network/dio_util.dart';
import 'package:flutter_chat/flavors/build_config.dart';

class GroupApi {

  final logger = BuildConfig.instance.config.logger;

  static Future<ApiResult?> groupList(int userId) async {
    var op = Options(
        contentType: Headers.jsonContentType,
        method: DioUtil.get);

    var formData = FormData.fromMap({'userId':userId});

    var response = await DioUtil.instance.request('/group/list', data: formData, options: op);
    ApiResult apiResult = ApiResult.fromJson(response.data);
    return apiResult;
  }

  static Future<ApiResult?> groupMembers(int groupId) async {
    var op = Options(
        contentType: Headers.jsonContentType,
        method: DioUtil.get);

    var formData = FormData.fromMap({'groupId':groupId});

    var response = await DioUtil.instance.request('/group/members', data: formData, options: op);
    ApiResult apiResult = ApiResult.fromJson(response.data);
    return apiResult;
  }
}