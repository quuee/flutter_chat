
import 'package:dio/dio.dart';
import 'package:flutter_chat/app/model/api_result.dart';
import 'package:flutter_chat/app/network/dio_util.dart';
import 'package:flutter_chat/flavors/build_config.dart';

class FileUploadApi {
  static final logger = BuildConfig.instance.config.logger;

  static Future<ApiResult?> uploadFile(
      {required String filePath,
      required String filename,
      required String mimeType}) async {
    var op = Options(
        contentType: Headers.multipartFormDataContentType,
        method: DioUtil.post);

    var formData = FormData();
    formData.fields.add(MapEntry('filename', filename));
    formData.fields.add(MapEntry('mimeType', mimeType));
    formData.files
        .addAll([MapEntry('file', MultipartFile.fromFileSync(filePath))]);
    try {
      var response = await DioUtil.instance.request('/upload/file', data: formData, options: op);
      ApiResult apiResult = ApiResult.fromJson(response.data);
      return apiResult;
    } on DioException catch (e) {
      logger.e('上传图片失败', error: e.message);
      return null;
    }
  }

}
