import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// 2.user.g.dart 将在我们运行生成命令后json_serializable帮我们自动生成.g.dart文件，在未执行命令前该行可能会报错
/**
 * 最后总结一下以json_serializable 的方式创建模型类必须5步:

    1.import 导入json_annotation.dart。
    import 'package:json_annotation/json_annotation.dart';
    2.json_serializable根据当前类，以part 类名.g.dart格式生成的文件。
    以user.dart为例如下:
    part 'user.g.dart';
    3.在class上标注 @JsonSerializable() 告诉json_serializable哪一个类需要进行转换生成Model类。
    4.创建必须的构造方法。
    5.创建必须的对应的工厂构造器。
 */

/// 认证失败，需要重新登录
const String kNeedAuthLoginErrorCode = "1001";

/// 需要重写
class ResponseData {
  int status = 0;
  String? errorCode;
  String errorMsg = "";
  dynamic? object;

  // 必须的构造方法
  ResponseData({required this.status, this.errorCode, this.errorMsg = "", this.object});

  // 必须有的对应工厂构造器
  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int;
    errorCode = json['errorCode'];
    if (json['errorMsg'] != null) {
      errorMsg = json['errorMsg'];
    }
    object = json['object'];
  }

  @override
  String toString() {
    return 'BaseRespData{status: $status, errorCode: $errorCode, message: $errorMsg, object: $object}';
  }
}