import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';


// 刷新的动画
class ChatLoadingIndicator extends StatelessWidget {
  const ChatLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            color: ColorUtil.hexColor(0x333333),
          ),
          const SizedBox(
            width: 10,
          ),
          buildIndicatorTitle(context),
        ],
      ),
    );
  }

  Widget buildIndicatorTitle(BuildContext context) {
    return Text(
      "加载中",
      textAlign: TextAlign.left,
      maxLines: 1000,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x555555),
        decoration: TextDecoration.none,
      ),
    );
  }
}

// 没有更多消息时候
class ChatNoMoreIndicator extends StatelessWidget {
  const ChatNoMoreIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      alignment: Alignment.center,
      // 不显示提示文本
      child: buildIndicatorTitle(context),
    );
  }

  Widget buildIndicatorTitle(BuildContext context) {
    return Text(
      "没有更多消息",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x555555),
        decoration: TextDecoration.none,
      ),
    );
  }
}
