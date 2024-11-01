import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_image_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';

// 红包
class ChatCellRedPacketElem extends StatefulWidget {
  const ChatCellRedPacketElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellRedPacketElem> createState() => _ChatCellRedPacketElemState();
}

class _ChatCellRedPacketElemState extends State<ChatCellRedPacketElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: [
          buildRedPacketBG(context),
          buildRedPacketContent(context),
        ],
      ),
    );
  }

  Widget buildRedPacketBG(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.wrapAssetAtImages(
        "icons/bg_show_redpacket.png",
        fit: BoxFit.cover,
        width: layoutBackgroundSize().width,
        height: layoutBackgroundSize().height,
      ),
    );
  }

  Widget buildRedPacketContent(BuildContext context) {
    return Container(
      width: layoutBackgroundSize().width,
      height: layoutBackgroundSize().height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.0,
          ),
          buildRedPacketIcon(context),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRedPacketTitle(context),
                SizedBox(
                  height: 5.0,
                ),
                buildRedPacketStatus(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRedPacketIcon(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.wrapAssetAtImages(
        "icons/icon_redpacket.png",
        fit: BoxFit.cover,
        width: 50.0,
        height: 50.0,
      ),
    );
  }

  Widget buildRedPacketTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.redPacketTitle ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0xffffff),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildRedPacketStatus(BuildContext context) {
    return Text(
      "${widget.chatMessage.redPacketStatus ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0xffffff),
        decoration: TextDecoration.none,
      ),
    );
  }

  Size layoutBackgroundSize() {
    return Size(260.0, 90.0);
  }
}
