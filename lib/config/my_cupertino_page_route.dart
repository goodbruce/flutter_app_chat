import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

class MyCupertinoPageRoute<T> extends CupertinoPageRoute {
  MyCupertinoPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => ColorUtil.hexColor(0x000000, alpha: 0.2);

  @override
  // A relatively rigorous eyeball estimation.
  Duration get transitionDuration => const Duration(milliseconds: 450);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 通过裁剪去除页面的shadow
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child:
          super.buildTransitions(context, animation, secondaryAnimation, child),
    );
  }
}
