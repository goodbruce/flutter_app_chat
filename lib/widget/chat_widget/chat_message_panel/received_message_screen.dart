import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/custom_shape.dart';

class ReceivedMessageScreen extends StatelessWidget {
  const ReceivedMessageScreen({
    Key? key,
    required this.child,
    this.color,
    this.padding,
    required this.messageScreenKey,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final GlobalKey messageScreenKey;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Transform(
        //   alignment: Alignment.center,
        //   transform: Matrix4.rotationY(math.pi),
        //   child: CustomPaint(
        //     painter: CustomShape(Colors.grey[300]!),
        //   ),
        // ),
        Flexible(
          child: Container(
            margin: padding ?? EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: color ?? Colors.white,
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
