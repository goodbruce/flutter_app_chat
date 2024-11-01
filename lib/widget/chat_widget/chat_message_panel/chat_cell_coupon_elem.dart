import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

// 分享的券
class ChatCellCouponElem extends StatefulWidget {
  const ChatCellCouponElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellCouponElem> createState() => _ChatCellCouponElemState();
}

class _ChatCellCouponElemState extends State<ChatCellCouponElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.all(10.0),
      child: buildLayout(context),
    );
  }

  Widget buildLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCouponTitle(context),
        SizedBox(
          height: 7.0,
        ),
        buildCouponContent(context),
        SizedBox(
          height: 7.0,
        ),
        buildImage(context),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.couponShareImageUrl}",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildCouponTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.couponTitle ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildCouponContent(BuildContext context) {
    return Text(
      "${widget.chatMessage.couponContent ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x333333),
        decoration: TextDecoration.none,
      ),
    );
  }
}
