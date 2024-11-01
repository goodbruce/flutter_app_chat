import 'package:flutter_app_chat/global/user_model.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

/// 接收认证信息数据
class ApiAuth {
  // 登录的token
  static String? getToken() {
    UserModel userModel = Provider.of<UserModel>(OneContext().context!, listen: false);
    return userModel.token;
  }

  // 设备的User-Agent
  static String? getUserAgent() {
    return "";
  }

  // 用户登录的IM
  static String? getIMUserId() {
    UserModel userModel = Provider.of<UserModel>(OneContext().context!, listen: false);
    return userModel.session.imUserId;
  }

  // 上传到七牛的token
  static String? getQiniuToken() {
    return "";
  }

  // 是否已经登录
  static bool checkLogin() {
    UserModel userModel = Provider.of<UserModel>(OneContext().context!, listen: false);
    return userModel.checkLogin();
  }
}
