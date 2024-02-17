import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/network/dio_util.dart';
import 'package:flutter_chat/flavors/build_config.dart';

class FileUploadApi {
  static final logger = BuildConfig.instance.config.logger;

  static Future<ApiResult?> uploadImage(File file) async {
    var op = Options(
        contentType: Headers.multipartFormDataContentType,
        method: DioUtil.post);

    var formData = FormData();
    // formData.fields.addAll({})
    formData.files.addAll([MapEntry('files', MultipartFile.fromFileSync(file.path))]);
    try {
      var response = await DioUtil.instance
          .request('/upload/images', data: formData, options: op);
      ApiResult apiResult = ApiResult.fromJson(response.data);
      return apiResult;
    } on DioException catch (e) {
      logger.e('上传图片失败', error: e.message);
      return null;
    }
  }
}
