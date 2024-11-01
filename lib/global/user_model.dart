import 'package:flutter_app_chat/config/router_manager.dart';
import 'package:flutter_app_chat/global/g_cache_model.dart';
import 'package:flutter_app_chat/global/user.dart';
import 'package:flutter_app_chat/global/session_model.dart';
import 'package:flutter_app_chat/network/api_auth.dart';

class UserModel extends SessionChangeNotifier {
  User? get user => session.user;

  static const String kUser = 'kUser';

  GlobalCacheModel globalCacheModel;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool isLogin = false;

  // APP登录的token认证信息
  String? get token => session.token ?? "";

  UserModel({required this.globalCacheModel}) {
    isLogin = checkLogin();
  }

  // 更新globalCacheModel
  void updateGlobalCacheModel(GlobalCacheModel globalCacheModel) {
    this.globalCacheModel = globalCacheModel;
  }

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User? user) {
    if (user != null && user!.userId == session.user?.userId) {
      session.lastLogin = session.user?.userId;
      session.user = user;
      isLogin = checkLogin();
    } else {
      session.user = user;
      isLogin = checkLogin();
    }

    print("isLogin:${isLogin}");

    notifyListeners();
  }

  //更新用户Im
  void updateUserIMInfo(String? imUserId, String? imUserSign) {
    session.imUserId = imUserId;
    session.imUserSign = imUserSign;

    notifyListeners();
  }

  // 获取IMUserID，imUserSign
  String? getImUserId() {
    return session.imUserId;
  }

  String? getImUserSign() {
    return session.imUserSign;
  }

  set token(String? token) {
    session.token = token;
    isLogin = checkLogin();
    print("isLogin:${isLogin}");
    notifyListeners();
  }

  bool checkLogin() {
    print("profile.token:${session.token}, profile.user:${session.user}");
    if (session.token != null &&
        session.token!.isNotEmpty &&
        (session.user != null &&
            session.user!.userId != null &&
            session.user!.userId!.isNotEmpty)) {
      return true;
    }

    return false;
  }

  // 清除数据
  void clear() {
    token = null;
    updateUserIMInfo(null, null);
  }
}
