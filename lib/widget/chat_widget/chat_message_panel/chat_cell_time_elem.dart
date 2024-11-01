import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

// 显示时间
class ChatCellTimeElem extends StatelessWidget {
  const ChatCellTimeElem({
    Key? key,
    required this.timeString,
  }) : super(key: key);

  final String timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20.0,
      child: Text(
        "${timeString}",
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: ColorUtil.hexColor(0x555555),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
