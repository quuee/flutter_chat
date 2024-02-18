// 定义枚举，请求方法枚举
// enum HttpApiMethod {
//   GET,
//   POST,
//   DELETE,
//   PUT,
// }
//
// // 网络请求的成功与失败
// // 上传
// typedef OnUploaded = void Function(Map<String, dynamic> result);
// // 下载进度
// typedef OnDownloadProgress = void Function(int count, int total);
// // 下载成功
// typedef OnDownloaded = void Function();
// // 请求成功
// typedef OnSuccess = void Function(ApiResult result);
// // 请求失败
// typedef OnFailure = void Function(ApiHttpError error);
//
// // 请求Api
// class DioUtil {
//   static final String baseUrl = BuildConfig.instance.config.baseUrl;
//
//   // 网络请求库dio
//   Dio dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: const Duration(seconds: 60),
//     receiveTimeout: const Duration(seconds: 10),
//     sendTimeout: const Duration(seconds: 60),
//     headers: {
//       HttpHeaders.acceptHeader: "text/plain,"
//           "text/plain,"
//           "multipart/form-data,"
//           "application/json,"
//           "text/html,"
//           "image/jpeg,"
//           "image/png,"
//           "application/octet-stream,"
//           "text/json,"
//           "text/javascript,"
//           "text/html",
//     },
//   ));
//
//   // 私有构造函数
//   DioUtil._internal() {
//     dio.interceptors.add(InterceptorsWrapper(
//         onRequest:
//             (RequestOptions options, RequestInterceptorHandler handler) {},
//         onResponse: (Response response, ResponseInterceptorHandler handler) {},
//         onError: (DioException e, ErrorInterceptorHandler handler) {}));
//     dio.interceptors.add(LogInterceptor(responseBody: true));
//   }
//
//   //保存单例
//   static final DioUtil _singleton = DioUtil._internal();
//
//   //工厂构造函数
//   factory DioUtil() => _singleton;
//
//   /// 配置请求头header
//   ///   /// The request Content-Type. The default value is 'application/json; charset=utf-8'.
//   //   /// If you want to encode request body with 'application/x-www-form-urlencoded',
//   //   /// you can set [Headers.formUrlEncodedContentType], and [Dio]
//   //   /// will automatically encode the request body.
//   Future<void> configHeaders(
//       String requestUrl, Map<String, dynamic>? params) async {
//     dio.options.headers['Content-Type'] = Headers.jsonContentType;
//
//     // LoggerManager().info(
//     //     "requestUrl：${requestUrl} dio.options.headers：${dio.options.headers}");
//   }
//
//   get(String url,
//       {Map<String, dynamic>? params,
//       OnSuccess? success,
//       OnFailure? failure,
//       Options? options}) async {
//     return await doRequest(url, HttpApiMethod.GET,
//         params: params, success: success, failure: failure, options: options);
//   }
//
//   post(String url,
//       {Map<String, dynamic>? params,
//       OnSuccess? success,
//       OnFailure? failure,
//       Options? options}) async {
//     return await doRequest(url, HttpApiMethod.POST,
//         params: params, success: success, failure: failure, options: options);
//   }
//
//   // 请求服务器
//   // params,参数
//   // 请求成功
//   // 请求失败
//   Future<ApiResult?> doRequest(String url, HttpApiMethod method,
//       {Map<String, dynamic>? params,
//       OnSuccess? success,
//       OnFailure? failure,
//       Options? options}) async {
//     String requestUrl = url;
//
//     try {
//       /// 可以添加header
//       await configHeaders(requestUrl, params);
//       Response? response;
//       switch (method) {
//         case HttpApiMethod.GET:
//           {
//             // get请求
//             if (params != null && params.isNotEmpty) {
//               response = await dio.get(requestUrl,
//                   queryParameters: params, // 拼接参数
//                   options: options??Options(contentType: Headers.jsonContentType));
//               // LoggerManager()
//               //     .debug("await dio.get response:$response,params:$params");
//             } else {
//               response = await dio.get(requestUrl,
//                   options: options??Options(contentType: Headers.jsonContentType));
//             }
//             break;
//           }
//         case HttpApiMethod.POST:
//           {
//             // post请求
//             String? contentType = Headers.formUrlEncodedContentType;
//             if (params != null && params.isNotEmpty) {
//               response = await dio.post(requestUrl,
//                   data: params, options: options??Options(contentType: contentType));
//               // LoggerManager()
//               //     .debug("await dio.post response:$response,params:$params");
//             } else {
//               response = await dio.post(requestUrl,
//                   options: options??Options(contentType: contentType));
//             }
//             break;
//           }
//         // case HttpApiMethod.PUT: {
//         //   break;
//         // }
//         // case HttpApiMethod.DELETE: {
//         //   break;
//         // }
//         default:
//       }
//       // LoggerManager().debug('doRequest: $response, params:$params');
//
//       if (response != null) {
//         Map<String, dynamic> result = json.decode(response.toString());
//         assert(() {
//           // assert只会在debug模式下执行，release模式下不会执行
//           // 打印信息
//           // LoggerManager().debug('''api: $requestUrl\nresult: $result''');
//           return true;
//         }());
//
//         ApiResult responseData = ApiResult.fromJson(result);
//         if (responseData.code == 0) {
//           if (success != null) {
//             //返回请求数据
//             success(responseData);
//           }
//         } else {
//           //返回失败信息
//           ApiHttpError apiHttpError = getErrorRequestResponseData(responseData);
//
//           // LoggerManager().debug("apiHttpError:${apiHttpError.toString()}");
//
//           // LoggerManager().error('''api: $requestUrl\nresult: $result''');
//
//           if (failure != null) {
//             failure(apiHttpError);
//           }
//         }
//         return responseData;
//       } else {
//         // 没有获得response，failure
//         ApiHttpError apiHttpError =
//             ApiHttpError(ApiHttpErrorType.Default, "请求失败!");
//
//         // LoggerManager().debug("apiHttpError:${apiHttpError.toString()}");
//
//         if (failure != null) {
//           failure(apiHttpError);
//         }
//         return null;
//       }
//     } on DioException catch (e, s) {
//       // catch到异常，failure
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//
//       // LoggerManager()
//       //     .error("doRequest api: $requestUrl, dioError:${e.message}, s:$s");
//       ApiHttpError apiHttpError = getRequestFailure(e.response, e.type);
//
//       // LoggerManager().debug("apiHttpError:${apiHttpError.toString()}");
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     } catch (e) {
//       // 可以捕获任意异常
//       ApiHttpError apiHttpError =
//           ApiHttpError(ApiHttpErrorType.Default, e.toString());
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     }
//   }
//
//   // 上传文件（图片）
//   doUploadFile(String url, UploadFileInfo fileInfo,
//       {Map<String, dynamic>? params,
//       OnUploaded? uploaded,
//       OnFailure? failure}) async {
//     try {
//       String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
//       Map<String, dynamic> fromParams = {};
//       if (params != null && params.isNotEmpty) {
//         fromParams.addAll(params);
//       }
//
//       fromParams["file"] = await MultipartFile.fromFile(fileInfo.file.path,
//           filename: '${fileInfo.key}-${timeStamp}.jpg');
//
//       FormData formData = FormData.fromMap(fromParams);
//       Response? response = await dio.post(url, data: formData);
//       assert(() {
//         // assert只会在debug模式下执行，release模式下不会执行
//         // 打印信息
//         // LoggerManager().error('''api: $url\nresult: $response''');
//         return true;
//       }());
//
//       Map<String, dynamic> result = json.decode(response.toString());
//       assert(() {
//         // assert只会在debug模式下执行，release模式下不会执行
//         // 打印信息
//         // LoggerManager().debug('''api: $url\nresult: $result''');
//         return true;
//       }());
//
//       if (response.statusCode == 200) {
//         if (uploaded != null) {
//           uploaded(result);
//         }
//       } else {
//         //返回失败信息
//         // LoggerManager().error('''api: $url\nresult: $result''');
//
//         ApiHttpError apiHttpError =
//             ApiHttpError(ApiHttpErrorType.Default, "请求失败!");
//
//         if (failure != null) {
//           failure(apiHttpError);
//         }
//       }
//     } on DioException catch (e, s) {
//       // catch到异常，failure
//       // LoggerManager().error("doUploadFile api: $url, dioError:$e, s:$s");
//       ApiHttpError apiHttpError = getRequestFailure(e.response, e.type);
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     } catch (e) {
//       // 可以捕获任意异常
//       ApiHttpError apiHttpError =
//           ApiHttpError(ApiHttpErrorType.Default, e.toString());
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     }
//   }
//
//   // 下载文件
//   void doDownload(String url, String savePath,
//       {required CancelToken cancelToken,
//       Map<String, dynamic>? params,
//       dynamic data,
//       Options? options,
//       OnDownloadProgress? progress,
//       OnDownloaded? completion,
//       OnFailure? failure}) async {
//     try {
//       dio.download(
//         url,
//         savePath,
//         queryParameters: params,
//         cancelToken: cancelToken,
//         onReceiveProgress: (int count, int total) {
//           if (total != -1) {
//             if (!cancelToken.isCancelled) {
//               double downloadRatio = (count / total);
//               if (downloadRatio == 1) {
//                 if (completion != null) {
//                   completion();
//                 }
//               } else {
//                 if (progress != null) {
//                   progress(count, total);
//                 }
//               }
//             }
//           } else {
//             ApiHttpError apiHttpError =
//                 ApiHttpError(ApiHttpErrorType.Default, "无法获取文件大小，下载失败!");
//
//             if (failure != null) {
//               failure(apiHttpError);
//             }
//           }
//         },
//       );
//     } on DioException catch (e) {
//       ApiHttpError apiHttpError =
//           ApiHttpError(ApiHttpErrorType.Default, e.toString());
//       if (CancelToken.isCancel(e)) {
//         apiHttpError = ApiHttpError(ApiHttpErrorType.Cancel, "下载已取消！");
//       } else {
//         if (e.response != null) {
//           apiHttpError = getRequestFailure(e.response, e.type);
//         } else {
//           apiHttpError =
//               ApiHttpError(ApiHttpErrorType.Default, e.message ?? "");
//         }
//       }
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     } on Exception catch (e) {
//       // EasyLoading.showError(e.toString());
//       ApiHttpError apiHttpError =
//           ApiHttpError(ApiHttpErrorType.Default, e.toString());
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     } catch (e) {
//       // 可以捕获任意异常
//       ApiHttpError apiHttpError =
//           ApiHttpError(ApiHttpErrorType.Default, e.toString());
//
//       if (failure != null) {
//         failure(apiHttpError);
//       }
//     }
//   }
//
//   // 根据服务器来拼接服务器具体地址
//   // String getRequestUrl(String url, ApiServiceDomain serviceDomain) {
//   //   String requestUrl = url;
//   //   return requestUrl;
//   // }
//
//   ApiHttpError getErrorRequestResponseData(ApiResult responseData) {
//     //返回失败信息
//     ApiHttpError apiHttpError =
//         ApiHttpError(ApiHttpErrorType.Default, responseData.msg);
//
//     if (400 == responseData.code) {
//       apiHttpError = ApiHttpError(ApiHttpErrorType.Auth, responseData.msg);
//     }
//
//     return apiHttpError;
//   }
//
//   ApiHttpError getRequestFailure(
//       Response? response, DioExceptionType dioErrorType) {
//     // LoggerManager()
//     //     .error("getRequestFailure: $response, dioError:$dioErrorType");
//
//     ApiHttpErrorType errorType = ApiHttpErrorType.Default;
//     String errorMessage = "请求失败!";
//
//     if (response != null) {
//       if (dioErrorType == DioExceptionType.connectionTimeout) {
//         errorType = ApiHttpErrorType.NetWork;
//         errorMessage = "网络链接异常!";
//       } else if (dioErrorType == DioExceptionType.sendTimeout) {
//         errorType = ApiHttpErrorType.Timeout;
//         errorMessage = "网络链接异常!";
//       } else if (dioErrorType == DioExceptionType.receiveTimeout) {
//         errorType = ApiHttpErrorType.Timeout;
//         errorMessage = "网络链接异常!";
//       } else if (dioErrorType == DioExceptionType.badResponse) {
//         // When the server response, but with a incorrect status, such as 404, 503...
//         if (response.statusCode == 401) {
//           errorType = ApiHttpErrorType.Auth;
//           errorMessage = "认证失败!";
//         } else if (response.statusCode == 400) {
//           errorType = ApiHttpErrorType.BadRequest;
//           errorMessage = "无效请求!";
//         } else if (response.statusCode == 404) {
//           errorType = ApiHttpErrorType.NotFound;
//           errorMessage = "访问的资源丢失了!";
//         } else if (response.statusCode == 405) {
//           // 请求的方法错误
//           errorType = ApiHttpErrorType.BadParamHeader;
//           errorMessage = "参数出错!";
//         } else if (response.statusCode! >= 500) {
//           errorType = ApiHttpErrorType.BadRequest;
//           errorMessage = "服务器居然累倒了!";
//         }
//       } else if (dioErrorType == DioExceptionType.cancel) {
//         errorType = ApiHttpErrorType.Cancel;
//         errorMessage = "请求已经取消";
//       }
//     } else {
//       errorType = ApiHttpErrorType.NetWork;
//       errorMessage = "网络链接异常!";
//     }
//
//     ApiHttpError apiHttpError = ApiHttpError(errorType, errorMessage);
//     return apiHttpError;
//   }
// }
//
// /// 上传的文件类
// class UploadFileInfo {
//   File file;
//   String key;
//
//   UploadFileInfo({required this.file, required this.key});
// }

import 'package:dio/dio.dart';
import 'package:flutter_chat/app/routes/app_pages.dart';
import 'package:flutter_chat/flavors/build_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Getx;

class DioUtil {
  static final String baseUrl = BuildConfig.instance.config.baseUrl;

  //请求时间
  static const int connectTimeout = 30;
  //响应时间
  static const int receiveTimeout = 30;

  static const int sendTimeout = 30;

  late Dio _mDio;
  late BaseOptions options;

  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String patch = 'patch';
  static const String delete = 'delete';

  static final DioUtil _instance = DioUtil._();
  factory DioUtil() => _instance;

  static DioUtil get instance => DioUtil();

  DioUtil._() {
    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: connectTimeout),
        receiveTimeout: const Duration(seconds: receiveTimeout),
        sendTimeout: const Duration(seconds: sendTimeout),
        contentType: Headers.jsonContentType);

    _mDio = Dio(options);

    _mDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
          // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。

          String token = '';
          if (token != _mDio.options.headers['authorization']) {
            Map<String, dynamic> header = Map();
            header['Authorization'] = token;
            options.headers.addAll(header);
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。

          // 凭证过期
          if (response.data['code'] == 493) {
            // 可能多个请求 跳转多次
            Fluttertoast.showToast(msg: '登录已过期请重新登录');
            Getx.Get.offAllNamed(Routes.LOGIN);

            return;
          }

          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
          // _handleError(error);
          return handler.next(e);
        },
      ),
    );
    _mDio.interceptors.add(LogInterceptor(responseBody: true));
  }

  ///query参数是拼接到url问号后面的，data是在请求体里的，由于get方法没有请求体，所以只能接受query
  Future<Response<T>> request<T>(String url,
      {Map<String, dynamic>? params, dynamic data, Options? options}) async {
    Response<T> resp = await _mDio.request(url,
        data: data, //data是在请求体里的
        queryParameters: params, //query参数是拼接到url问号后面的
        options: options);
    return resp;
  }

  Future<void> download(
      {required String url,
      required String savePath,
      required onReceiveProgress,
      Options? options}) async {
    _mDio.download(url, savePath,
        onReceiveProgress: onReceiveProgress, options: options);
  }
}
