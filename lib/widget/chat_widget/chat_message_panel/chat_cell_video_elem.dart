import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_image_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

// 视频
class ChatCellVideoElem extends StatefulWidget {
  const ChatCellVideoElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellVideoElem> createState() => _ChatCellVideoElemState();
}

class _ChatCellVideoElemState extends State<ChatCellVideoElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Stack(
        children: [
          buildImage(context),
          buildVideoPlayIcon(context),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    Size imageSize = showImageSize(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.videoThumbImageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }

  Widget buildVideoPlayIcon(BuildContext context) {
    Size imageSize = showImageSize(context);
    return Container(
      width: imageSize.width,
      height: imageSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: ColorUtil.hexColor(0x000000, alpha: 0.45),
      ),
      child: ButtonWidget(
        onPressed: () {},
        child: ImageHelper.wrapAssetAtImages(
          "icons/ic_video_play_w.png",
          width: 50.0,
          height: 50.0,
        ),
      ),
    );
  }

  Size showImageSize(BuildContext context) {
    Size imageSize = Size.zero;
    double maxWidth = 240.0;
    double maxHeight = 500.0;
    imageSize = ChatCellImageLayout.showPreImageSize(
        widget.chatMessage.videoThumbImageSize ?? Size.zero,
        maxWidth,
        maxHeight);

    return imageSize;
  }
}
