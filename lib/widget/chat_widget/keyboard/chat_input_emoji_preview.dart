import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_emoji.dart';

/// 表情长按预览功能
class ChatInputEmojiPreview extends StatefulWidget {
  const ChatInputEmojiPreview({
    Key? key,
    required this.emojiItem,
    required this.width,
    required this.height,
  }) : super(key: key);

  final CommonChatEmojiItem emojiItem;
  final double width;
  final double height;

  @override
  State<ChatInputEmojiPreview> createState() => _ChatInputEmojiPreviewState();
}

class _ChatInputEmojiPreviewState extends State<ChatInputEmojiPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChatInputEmojiShowEmoji(
        emojiItem: widget.emojiItem,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

// 显示预览的内容
class ChatInputEmojiShowEmoji extends StatelessWidget {
  const ChatInputEmojiShowEmoji({
    Key? key,
    required this.emojiItem,
    required this.width,
    required this.height,
  }) : super(key: key);

  final CommonChatEmojiItem emojiItem;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          ImageHelper.wrapAssetAtImages(
            "icons/bg_emoji-preview.png",
            width: width,
            height: height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25.0,
              ),
              ImageHelper.imageNetwork(
                imageUrl: "${emojiItem.url}",
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                "${emojiItem.emojiName}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: ColorUtil.hexColor(0x555555),
                  decoration: TextDecoration.none,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
