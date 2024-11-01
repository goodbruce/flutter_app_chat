import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_chat/network/response_data.dart';

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message = "";

  NotSuccessException.fromRespData(ResponseData respData) {
    message = respData.errorMsg;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}


/// 定义网络请求Error类型
enum ApiHttpErrorType {
  Default,        //默认
  NetWork,        //网络出错
  Timeout,        //请求超时
  NotFound,       //404资源不存在
  BadRequest,     //非法请求
  BadParamHeader, //非法请求
  ForbidRequest,  //禁止访问
  Auth,           //认证失败
  ServerDown,     //服务器出错
  Cancel,         //请求取消

  //自定义错误码
  NotLogin,      //未登录，无法获取资源
  JsonParse,     //数据解析失败
}

/// 网络请求Error类
class ApiHttpError {
  ApiHttpErrorType errorType;
  String message;

  ApiHttpError(this.errorType, this.message);

  static ApiHttpError defaultError({String? message}) {
    return ApiHttpError(ApiHttpErrorType.Default, message??"");
  }

  @override
  String toString() {
    return "errorType:${this.errorType}, " + "message:${this.message}";
  }
}
