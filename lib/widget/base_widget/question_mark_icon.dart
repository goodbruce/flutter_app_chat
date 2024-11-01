import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

class QuestionMarkIcon extends StatelessWidget {
  const QuestionMarkIcon({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      width: 14.0,
      height: 14.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xffffff),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color ?? ColorUtil.hexColor(0xbcbcbc),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Icon(
        Icons.question_mark_rounded,
        color: color ?? ColorUtil.hexColor(0xbcbcbc),
        size: 10,
      ),
    );
  }
}
