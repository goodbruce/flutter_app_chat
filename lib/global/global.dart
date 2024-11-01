import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_chat/global/session.dart';
import 'package:flutter_app_chat/network/api_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static late SharedPreferences _prefs;
  static Session session = Session();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("session");
    if (_profile != null) {
      try {
        session = Session.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      // 默认主题索引为0，代表蓝色
      session = Session()..theme = 0;
    }
  }

  // 持久化Profile信息
  static void saveProfile() {
    _prefs.setString("session", jsonEncode(session.toJson()));
  }
}
