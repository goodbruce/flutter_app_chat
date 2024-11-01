import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_chat/channel/my_boost_flutter_binding.dart';
import 'package:flutter_app_chat/global/global.dart';
import 'package:flutter_app_chat/qun_myapp.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:ui';

void main() {
  ///这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
  MyBoostFlutterBinding();

  // 配置provider
  Provider.debugCheckInvalidValueType = null;

  Global.init().then((e) {
    OnePlatform.app = () => const QunMyApp();
  });

  configLoading();
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  // 设置竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runZonedGuarded<Future<void>>(
  //       () async {
  //     if (ensureInitialized) {
  //       WidgetsFlutterBinding.ensureInitialized();
  //     }
  //     callback();
  //   },
  //   _reportError,
  // );
}



void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

