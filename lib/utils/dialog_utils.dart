import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/common_widget/show_alert_dialog.dart';
import 'package:flutter_app_chat/widget/common_widget/show_sheet_dialog.dart';
import 'package:one_context/one_context.dart';

class DialogUtil {
  //显示中间弹窗
  static void popDialog(BuildContext context, Widget widget) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return widget;
        });
  }

  //显示底部弹窗
  static void bottomSheetDialog(
    BuildContext context,
    Widget widget, {
    bool? isScrollControlled,
    bool? enableDrag,
    Color? backgroundColor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled ?? true,
      enableDrag: enableDrag ?? true,
      backgroundColor: backgroundColor ?? Colors.white,
      builder: (ctx) {
        return widget;
      },
    );
  }

  //返回上一级
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  //push到下一级
  static Future push(BuildContext context, Widget widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
