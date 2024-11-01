import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

// 游戏链接
class ChatCellGameWebElem extends StatefulWidget {
  const ChatCellGameWebElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellGameWebElem> createState() => _ChatCellGameWebElemState();
}

class _ChatCellGameWebElemState extends State<ChatCellGameWebElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(10.0),
      child: buildLayout(context),
    );
  }

  Widget buildLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(context),
        SizedBox(
          height: 7.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context),
            SizedBox(
              width: 7.0,
            ),
            Expanded(
              child: buildIntro(context),
            ),
          ],
        )
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    Size imageSize = Size(70, 70);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.gShareImageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      "${widget.chatMessage.gWebTitle ?? ""}",
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

  Widget buildIntro(BuildContext context) {
    return Text(
      "${widget.chatMessage.gWebContent ?? ""}",
      textAlign: TextAlign.left,
      maxLines: 2,
      softWrap: true,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0xAAAAAA),
        decoration: TextDecoration.none,
      ),
    );
  }
}
