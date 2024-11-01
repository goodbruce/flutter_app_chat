import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_app_chat/widget/common_widget/custom_loading_Indicator.dart';

class FlutterLoadingHud {
  static void showLoading({String? message}) {
    if (message != null && message.isNotEmpty) {
      EasyLoading.show(
        status: message,
        indicator: CustomLoadingIndicator(),
        // indicator: CircularProgressIndicator(
        //   strokeWidth: 2,
        //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        // ),
      );
    }
  }

  static void showToast({String? message}) {
    if (message != null && message.isNotEmpty) {
      EasyLoading.showToast(message);
    }
  }

  static void showError({String? message}) {
    if (message != null && message.isNotEmpty) {
      EasyLoading.showError(message);
    }
  }

  static void showSuccess({String? message}) {
    if (message != null && message.isNotEmpty) {
      EasyLoading.showSuccess(message);
    }
  }

  static void showProgress({required double value, String? message}) {
    EasyLoading.showProgress(value, status: message);
  }

  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }
}
