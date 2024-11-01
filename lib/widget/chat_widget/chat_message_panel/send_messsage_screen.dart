import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/custom_shape.dart';

class SentMessageScreen extends StatelessWidget {
  const SentMessageScreen({
    Key? key,
    required this.child,
    this.color,
    this.padding,
    required this.indicatorType,
    required this.onSendFailedIndicatorPressed,
    required this.messageScreenKey,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final SendMessageIndicatorType indicatorType;
  final Function onSendFailedIndicatorPressed;
  final GlobalKey messageScreenKey;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.0),
          child: SendMessageIndicator(
            width: 30,
            height: 30,
            indicatorType: indicatorType,
            onSendFailedIndicatorPressed: onSendFailedIndicatorPressed,
          ),
        ),
        Flexible(
          child: Container(
            padding: padding ?? EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: color ?? ColorUtil.hexColor(0x95ec69),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Container(
              child: child,
              key: messageScreenKey,
            ),
          ),
        ),
        // CustomPaint(painter: CustomShape(Colors.cyan[900]!)),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 60.0, left: 60.0, top: 0.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 60.0),
          messageTextGroup,
        ],
      ),
    );
  }
}

enum SendMessageIndicatorType {
  none, // 无指示器
  sending, // 发送中
  sendFailed, // 发送失败
}

// 发送状态指示器
class SendMessageIndicator extends StatelessWidget {
  const SendMessageIndicator({
    Key? key,
    required this.width,
    required this.height,
    required this.indicatorType,
    required this.onSendFailedIndicatorPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final SendMessageIndicatorType indicatorType;
  final Function onSendFailedIndicatorPressed;

  @override
  Widget build(BuildContext context) {
    if (SendMessageIndicatorType.sending == indicatorType) {
      return Container(
        height: width,
        width: height,
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(
          color: ColorUtil.hexColor(0x333333),
        ),
      );
    }

    if (SendMessageIndicatorType.sendFailed == indicatorType) {
      return ButtonWidget(
        height: width,
        width: height,
        onPressed: () {
          onSendFailedIndicatorPressed();
        },
        child: ImageHelper.wrapAssetAtImages(
          "icons/ic_messsage_failed.png",
          height: width,
          width: height,
        ),
      );
    }

    return Container();
  }
}
