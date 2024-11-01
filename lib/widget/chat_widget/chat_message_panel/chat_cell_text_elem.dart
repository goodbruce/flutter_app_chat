import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_richtext_helper.dart';

class ChatCellTextElem extends StatefulWidget {
  const ChatCellTextElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellTextElem> createState() => _ChatCellTextElemState();
}

class _ChatCellTextElemState extends State<ChatCellTextElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: buildTextContent(),
    );
  }

  Widget buildTextContent() {
    // 富文本
    return CommChatRichTextHelper.getRichText("${widget.chatMessage.text ?? ""}");
  }
}
