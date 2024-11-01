import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/global.dart';
import 'package:flutter_app_chat/global/session_model.dart';

class ThemeModel extends SessionChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  MaterialColor get theme => Global.themes
      .firstWhere((e) => e.value == session.theme, orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(MaterialColor color) {
    if (color != theme) {
      session.theme = color[500]?.value;
      notifyListeners();
    }
  }
}