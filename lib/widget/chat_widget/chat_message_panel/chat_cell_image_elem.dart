import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';

class ChatCellImageElem extends StatefulWidget {
  const ChatCellImageElem({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final CommonChatMessage chatMessage;

  @override
  State<ChatCellImageElem> createState() => _ChatCellImageElemState();
}

class _ChatCellImageElemState extends State<ChatCellImageElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(0.0),
      child: buildImage(context),
    );
  }

  Widget buildImage(BuildContext context) {
    Size imageSize = Size.zero;
    if (widget.chatMessage.isGif || widget.chatMessage.isSticker) {
      imageSize = Size(120, 120);
    } else {
      double maxWidth = 240.0;
      double maxHeight = 500.0;
      imageSize = ChatCellImageLayout.showPreImageSize(
          widget.chatMessage.imageSize ?? Size.zero, maxWidth, maxHeight);
    }

    String imageUrl = "${widget.chatMessage.imageUrl ?? ""}";
    String start = "file://";
    if (imageUrl.startsWith(start)) {
      String imageAssetFile = imageUrl.substring(start.length);
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: ImageHelper.wrapAssetAtImages(
          imageAssetFile,
          fit: BoxFit.cover,
          width: imageSize.width,
          height: imageSize.height,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: ImageHelper.imageNetwork(
        imageUrl: "${widget.chatMessage.imageUrl}",
        fit: BoxFit.cover,
        width: imageSize.width,
        height: imageSize.height,
      ),
    );
  }
}

class ChatCellImageLayout {
  /**
      预览图所用尺寸

      @param imageSize width
      @param maxWidth 最大长度
      @param maxHeight 最大高度
      @return CSIze
   */
  static Size showPreImageSize(
      Size imageSize, double maxWidth, double maxHeight) {
    Size size = Size.zero;
    double picWidth = imageSize.width;
    double picHeight = imageSize.height;

    int tag;
    if (picHeight > picWidth) {
      //竖
      if (picHeight / picWidth > 3.0) {
        tag = 3; //竖长图
      } else {
        tag = 2; //竖图
      }
    } else {
      //横
      if (picWidth / picHeight > 3.0) {
        tag = 4; //横长图
      } else {
        tag = 1; //横图
      }
    }

    switch (tag) {
      case 1:
        {
          double sizeWidth;
          if (picHeight == 0 || picWidth == 0) {
            sizeWidth = 0;
          } else {
            sizeWidth = maxWidth * 2.6 * picHeight / 3.0 / picWidth;
          }
          size = Size(maxWidth * 2.6 / 3.0, sizeWidth);
          break;
        }
      case 2:
        {
          size = Size(maxWidth * 2.6 * picWidth / 3.0 / picHeight,
              maxWidth * 2.6 / 3.0);
          break;
        }
      case 3:
        {
          size = Size(maxWidth * 2.6 / 9.0, maxWidth * 2.6 / 3.0);
          break;
        }
      case 4:
        {
          size = Size(maxWidth, maxWidth / 3.0);
          break;
        }
      default:
        break;
    }
    return size;
  }
}
