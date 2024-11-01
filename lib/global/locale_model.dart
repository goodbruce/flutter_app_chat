import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/session_model.dart';

class LocaleModel extends SessionChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {
    if (session.locale == null) return null;
    var t = session.locale?.split("_");
    print("getLocale t:${t}");
    if (t != null && t.length == 2) {
      print("Locale t:${t}");
      return Locale(t[0], t[1]);
    }

    return null;
  }

  // 获取当前Locale的字符串表示
  String get locale => session.locale ?? "";

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    print("locale:${locale}, profile.locale:${session.locale}");
    if (locale != session.locale) {
      session.locale = locale;
      notifyListeners();
    }
  }
}
