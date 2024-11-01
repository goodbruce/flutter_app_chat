import 'package:flutter/cupertino.dart';
import 'package:one_context/one_context.dart';

enum AppRunMode { defaultMode, boostMode }

// const AppRunMode kCurrentAppRunMode = AppRunMode.boostMode; // 当前使用boost模式
const AppRunMode kCurrentAppRunMode = AppRunMode.defaultMode; // 当前使用默认模式

// 导航路由跳转
class NavigatorRoute {
  static void push(String name,
      {Map<String, dynamic>? arguments,
      bool withContainer = false,
      bool opaque = true,
      Function? onCallback}) {
    OneContext().pushNamed(name, arguments: arguments).then((value) {
      if (onCallback != null) {
        onCallback(value);
      }
    });
  }

  static void pushReplacementNamed(String name,
      {Map<String, dynamic>? arguments,
      bool withContainer = false,
      bool opaque = true,
      Function? onCallback}) {
    OneContext.instance
        .pushReplacementNamed(name, arguments: arguments)
        .then((value) {
      if (onCallback != null) {
        onCallback(value);
      }
    });
  }

  static void pushNamedAndRemoveUntil(String name,
      {Map<String, dynamic>? arguments,
      bool withContainer = false,
      bool opaque = true,
      Function? onCallback}) {
    OneContext.instance.pushNamedAndRemoveUntil(name, (Route<dynamic> route) {
      return false;
    }, arguments: arguments).then((value) {
      if (onCallback != null) {
        onCallback(value);
      }
    });
  }

  static void pop([result]) {
    OneContext().pop(result);
  }
}
