import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

// 位置
class ChatCellLocationElem extends StatefulWidget {
  const ChatCellLocationElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellLocationElem> createState() => _ChatCellLocationElemState();
}

class _ChatCellLocationElemState extends State<ChatCellLocationElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: buildLocationLayout(context),
    );
  }

  Widget buildLocationLayout(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          buildLocalBG(context),
          Positioned(
            bottom: 0.0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: buildLocationContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocalBG(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.wrapAssetAtImages(
        "icons/icon_map.png",
        fit: BoxFit.cover,
        width: layoutSize().width,
        height: layoutSize().height,
      ),
    );
  }

  Widget buildLocationContent(BuildContext context) {
    return Container(
      width: layoutSize().width,
      child: Text(
        "${widget.chatMessage.locationInfo ?? ""}",
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: ColorUtil.hexColor(0xffffff),
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Size layoutSize() {
    return Size(180.0, 130.0);
  }
}
