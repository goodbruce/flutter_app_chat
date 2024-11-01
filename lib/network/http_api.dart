import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app_chat/config/navigator_route.dart';
import 'package:flutter_app_chat/network/api_auth.dart';
import 'package:flutter_app_chat/network/api_config.dart';
import 'package:flutter_app_chat/network/response_data.dart';
import 'package:flutter_app_chat/utils/platform_utils.dart';

// 定义枚举，请求服务器枚举
enum ApiServiceDomain {
  none,   // 默认服务器
}

// 定义枚举，请求方法枚举
enum HttpApiMethod {
  GET,
  POST,
  DELETE,
  PUT,
}

// 网络请求的成功与失败
// 上传
typedef OnUploaded = void Function(Map<String, dynamic> result);
// 下载进度
typedef OnDownloadProgress = void Function(int count, int total);
// 下载成功
typedef OnDownloaded = void Function();
// 请求成功
typedef OnSuccess = void Function(ResponseData responseData);
// 请求失败
typedef OnFailure = void Function(ApiHttpError error);

// 请求Api
class HttpApi {
  // 网络请求库dio
  Dio dio = Dio(BaseOptions(
    // connectTimeout: 60000, // 连接服务器超时时间，单位是毫秒.
    // receiveTimeout: 10000, // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限
    headers: {
      HttpHeaders.acceptHeader: "text/plain,"
          "text/plain,"
          "multipart/form-data,"
          "application/json,"
          "text/html,"
          "image/jpeg,"
          "image/png,"
          "application/octet-stream,"
          "text/json,"
          "text/javascript,"
          "text/html",
    },
  ));

  // 私有构造函数
  HttpApi._internal();

  //保存单例
  static HttpApi _singleton = HttpApi._internal();

  //工厂构造函数
  factory HttpApi() => _singleton;

  /// 配置请求头header
  ///   /// The request Content-Type. The default value is 'application/json; charset=utf-8'.
  //   /// If you want to encode request body with 'application/x-www-form-urlencoded',
  //   /// you can set [Headers.formUrlEncodedContentType], and [Dio]
  //   /// will automatically encode the request body.
  Future<void> configHeaders(
      String requestUrl, Map<String, dynamic>? params) async {
    if (AppRunMode.boostMode == kCurrentAppRunMode) {
      dio.options.headers = {
        "Authorization": ApiAuth.getToken(),
        "User-Agent": ApiAuth.getUserAgent()
      };
    } else {
      dio.options.headers = {
        "Authorization": ApiAuth.getToken(),
        "User-Agent":
            "[D687D0BF-0397-4077-866C-1D1B57956AE0;iPhone;iosApp;1.0.0;10001;20220629161657;wwan;;iOS;14.0.1;750*1334;zh-CN;;]"
      };
    }

    dio.options.headers['Content-Type'] = Headers.jsonContentType;
    await setHttpRequestCookie(url: requestUrl, params: params);

    print(
        "requestUrl：${requestUrl} dio.options.headers：${dio.options.headers}");
  }

  get(String url, ApiServiceDomain serviceDomain,
      {Map<String, dynamic>? params, OnSuccess? success, OnFailure? failure}) {
    doRequest(url, serviceDomain, HttpApiMethod.GET,
        params: params, success: success, failure: failure);
  }

  post(String url, ApiServiceDomain serviceDomain,
      {Map<String, dynamic>? params, OnSuccess? success, OnFailure? failure}) {
    doRequest(url, serviceDomain, HttpApiMethod.POST,
        params: params, success: success, failure: failure);
  }

  // 请求服务器
  // params,参数
  // 请求成功
  // 请求失败
  Future<void> doRequest(
      String url, ApiServiceDomain serviceDomain, HttpApiMethod method,
      {Map<String, dynamic>? params,
      OnSuccess? success,
      OnFailure? failure}) async {
    String requestUrl = getRequestUrl(url, serviceDomain);

    try {
      /// 可以添加header
      await configHeaders(requestUrl, params);
      Response? response;
      switch (method) {
        case HttpApiMethod.GET:
          {
            // get请求
            if (params != null && params.isNotEmpty) {
              response = await dio.get(requestUrl,
                  queryParameters: params,
                  options: Options(contentType: Headers.jsonContentType));
              print("await dio.get response:$response,params:$params");
            } else {
              response = await dio.get(requestUrl,
                  options: Options(contentType: Headers.jsonContentType));
            }
            break;
          }
        case HttpApiMethod.POST:
          {
            // post请求
            String? contentType = Headers.formUrlEncodedContentType;
            contentType = Headers.jsonContentType;

            if (params != null && params.isNotEmpty) {
              response = await dio.post(requestUrl,
                  data: params, options: Options(contentType: contentType));
              print("await dio.post response:$response,params:$params");
            } else {
              response = await dio.post(requestUrl,
                  options: Options(contentType: contentType));
            }
            break;
          }
        default:
      }
      print('url:${requestUrl}, doRequest: $response, params:$params');

      if (response != null) {
        Map<String, dynamic> result = json.decode(response.toString());
        assert(() {
          // assert只会在debug模式下执行，release模式下不会执行
          // 打印信息
          print('''api: $requestUrl\nresult: $result''');
          return true;
        }());

        ResponseData responseData = ResponseData.fromJson(result);
        if (responseData.status == 0) {
          if (success != null) {
            //返回请求数据
            success(responseData);
          }
        } else {
          //返回失败信息
          ApiHttpError apiHttpError = getErrorRequestResponseData(responseData);

          print("apiHttpError:${apiHttpError.toString()}");

          checkNeedAuthLogin(apiHttpError);

          print('''api: $requestUrl\nresult: $result''');

          if (failure != null) {
            failure(apiHttpError);
          }
        }
      } else {
        // 没有获得response，failure
        ApiHttpError apiHttpError =
            ApiHttpError(ApiHttpErrorType.Default, "请求失败!");

        print("apiHttpError:${apiHttpError.toString()}");

        checkNeedAuthLogin(apiHttpError);

        if (failure != null) {
          failure(apiHttpError);
        }
      }
    } on DioError catch (e, s) {
      // catch到异常，failure
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      print("doRequest api: $requestUrl, dioError:${e.message}, s:$s");
      ApiHttpError apiHttpError = getRequestFailure(e.response, e.type);

      print("apiHttpError:${apiHttpError.toString()}");

      checkNeedAuthLogin(apiHttpError);

      if (failure != null) {
        failure(apiHttpError);
      }
    } catch (e) {
      // 可以捕获任意异常
      ApiHttpError apiHttpError =
          ApiHttpError(ApiHttpErrorType.Default, "${e.toString()}");

      if (failure != null) {
        failure(apiHttpError);
      }
    }
  }

  // 上传文件（图片）
  doUploadFile(String url, UploadFileInfo fileInfo,
      {Map<String, dynamic>? params,
      OnUploaded? uploaded,
      OnFailure? failure}) async {
    try {
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> fromParams = Map();
      if (params != null && params.isNotEmpty) {
        fromParams.addAll(params);
      }

      fromParams["file"] = await MultipartFile.fromFile(fileInfo.file.path,
          filename: '${fileInfo.key}-${timeStamp}.jpg');

      FormData formData = FormData.fromMap(fromParams);
      Response? response = await dio.post(url, data: formData);
      assert(() {
        // assert只会在debug模式下执行，release模式下不会执行
        // 打印信息
        print('''api: $url\nresult: $response''');
        return true;
      }());

      if (response != null) {
        Map<String, dynamic> result = json.decode(response.toString());
        assert(() {
          // assert只会在debug模式下执行，release模式下不会执行
          // 打印信息
          print('''api: $url\nresult: $result''');
          return true;
        }());

        if (response.statusCode == 200) {
          if (uploaded != null) {
            uploaded(result);
          }
        } else {
          //返回失败信息
          print('''api: $url\nresult: $result''');

          ApiHttpError apiHttpError =
              ApiHttpError(ApiHttpErrorType.Default, "请求失败!");

          if (failure != null) {
            failure(apiHttpError);
          }
        }
      } else {
        //返回失败信息
        // 没有获得response，failure
        ApiHttpError apiHttpError =
            ApiHttpError(ApiHttpErrorType.Default, "请求失败!");

        if (failure != null) {
          failure(apiHttpError);
        }
      }
    } on DioError catch (e, s) {
      // catch到异常，failure
      print("doUploadFile api: $url, dioError:$e, s:$s");
      ApiHttpError apiHttpError = getRequestFailure(e.response, e.type);

      if (failure != null) {
        failure(apiHttpError);
      }
    } catch (e) {
      // 可以捕获任意异常
      ApiHttpError apiHttpError =
          ApiHttpError(ApiHttpErrorType.Default, "${e.toString()}");

      if (failure != null) {
        failure(apiHttpError);
      }
    }
  }

  // 下载文件
  void doDownload(String url, String savePath,
      {required CancelToken cancelToken,
      Map<String, dynamic>? params,
      dynamic? data,
      Options? options,
      OnDownloadProgress? progress,
      OnDownloaded? completion,
      OnFailure? failure}) async {
    try {
      dio.download(
        url,
        savePath,
        queryParameters: params,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          if (total != -1) {
            if (!cancelToken.isCancelled) {
              double downloadRatio = (count / total);
              if (downloadRatio == 1) {
                if (completion != null) {
                  completion();
                }
              } else {
                if (progress != null) {
                  progress(count, total);
                }
              }
            }
          } else {
            ApiHttpError apiHttpError =
                ApiHttpError(ApiHttpErrorType.Default, "无法获取文件大小，下载失败!");

            if (failure != null) {
              failure(apiHttpError);
            }
          }
        },
      );
    } on DioError catch (e) {
      ApiHttpError apiHttpError =
          ApiHttpError(ApiHttpErrorType.Default, e.toString());
      if (CancelToken.isCancel(e)) {
        apiHttpError = ApiHttpError(ApiHttpErrorType.Cancel, "下载已取消！");
      } else {
        if (e.response != null) {
          apiHttpError = getRequestFailure(e.response, e.type);
        } else {
          apiHttpError = ApiHttpError(ApiHttpErrorType.Default, e.message??"");
        }
      }

      if (failure != null) {
        failure(apiHttpError);
      }
    } on Exception catch (e) {
      // EasyLoading.showError(e.toString());
      ApiHttpError apiHttpError =
          ApiHttpError(ApiHttpErrorType.Default, e.toString());

      if (failure != null) {
        failure(apiHttpError);
      }
    } catch (e) {
      // 可以捕获任意异常
      ApiHttpError apiHttpError =
          ApiHttpError(ApiHttpErrorType.Default, "${e.toString()}");

      if (failure != null) {
        failure(apiHttpError);
      }
    }
  }

  // 根据服务器来拼接服务器具体地址
  String getRequestUrl(String url, ApiServiceDomain serviceDomain) {
    String requestUrl = url;

    return requestUrl;
  }

  ApiHttpError getErrorRequestResponseData(ResponseData responseData) {
    //返回失败信息
    ApiHttpError apiHttpError =
        ApiHttpError(ApiHttpErrorType.Default, responseData.errorMsg);

    if (kNeedAuthLoginErrorCode == responseData.errorCode) {
      apiHttpError = ApiHttpError(ApiHttpErrorType.Auth, responseData.errorMsg);
    }

    return apiHttpError;
  }

  ApiHttpError getRequestFailure(
      Response? response, DioErrorType dioErrorType) {
    print("getRequestFailure: $response, dioError:$dioErrorType");

    ApiHttpErrorType errorType = ApiHttpErrorType.Default;
    String errorMessage = "请求失败!";

    if (response != null) {
      if (dioErrorType == DioErrorType.connectionTimeout) {
        errorType = ApiHttpErrorType.NetWork;
        errorMessage = "网络链接异常!";
      } else if (dioErrorType == DioErrorType.sendTimeout) {
        errorType = ApiHttpErrorType.Timeout;
        errorMessage = "网络链接异常!";
      } else if (dioErrorType == DioErrorType.receiveTimeout) {
        errorType = ApiHttpErrorType.Timeout;
        errorMessage = "网络链接异常!";
      } else if (dioErrorType == DioErrorType.badResponse) {
        // When the server response, but with a incorrect status, such as 404, 503...
        if (response != null) {
          if (response.statusCode == 401) {
            errorType = ApiHttpErrorType.Auth;
            errorMessage = "认证失败!";
          } else if (response.statusCode == 400) {
            errorType = ApiHttpErrorType.BadRequest;
            errorMessage = "无效请求!";
          } else if (response.statusCode == 404) {
            errorType = ApiHttpErrorType.NotFound;
            errorMessage = "访问的资源丢失了!";
          } else if (response.statusCode == 405) {
            // 请求的方法错误
            errorType = ApiHttpErrorType.BadParamHeader;
            errorMessage = "参数出错!";
          } else if (response.statusCode! >= 500) {
            errorType = ApiHttpErrorType.BadRequest;
            errorMessage = "服务器居然累倒了!";
          }
        }
      } else if (dioErrorType == DioErrorType.cancel) {
        errorType = ApiHttpErrorType.Cancel;
        errorMessage = "请求已经取消";
      }
    } else {
      errorType = ApiHttpErrorType.NetWork;
      errorMessage = "网络链接异常!";
    }

    ApiHttpError apiHttpError = ApiHttpError(errorType, errorMessage);
    return apiHttpError;
  }

  Future<void> setHttpRequestCookie(
      {required String url, Map<String, dynamic>? params}) async {
  }

  void checkNeedAuthLogin(ApiHttpError apiHttpError) {
    print(
        "ApiAuth token：${ApiAuth.getToken()}, imUserId：${ApiAuth.getIMUserId()}");
    if (ApiAuth.checkLogin()) {
      if (ApiHttpErrorType.Auth == apiHttpError.errorType) {
        print("checkNeedAuthLogin");
      }
    }
  }
}

/// 上传的文件类
class UploadFileInfo {
  File file;
  String key;

  UploadFileInfo({required this.file, required this.key});
}
