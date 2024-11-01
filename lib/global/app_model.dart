import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/session_model.dart';

// App统一的model,
class AppModel extends SessionChangeNotifier {

  // 是否同意用户协议
  String? get isAgree => session.isUserAgree;

  set userAgreement(String? agree) {
    session.isUserAgree = agree;
    notifyListeners();
  }
}