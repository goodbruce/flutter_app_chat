import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/global.dart';
import 'package:flutter_app_chat/global/session.dart';
import 'package:flutter_app_chat/global/user.dart';

// 共享状态
class SessionChangeNotifier with ChangeNotifier {
  Session get session => Global.session;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}