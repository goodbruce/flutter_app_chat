import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_menu/chat_bubble_menu_shape.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'dart:math' as math; // import this

// 长按气泡菜单的容器
class ChatBubbleMenuContainer extends StatefulWidget {
  const ChatBubbleMenuContainer({
    Key? key,
    required this.chatMessage,
    required this.bubbleOffset,
    required this.bubbleSize,
    required this.onBubbleMenuButtonPressed,
  }) : super(key: key);

  final CommonChatMessage chatMessage;
  final Offset bubbleOffset;
  final Size bubbleSize;
  final Function(int index) onBubbleMenuButtonPressed;

  @override
  State<ChatBubbleMenuContainer> createState() =>
      _ChatBubbleMenuContainerState();
}

class _ChatBubbleMenuContainerState extends State<ChatBubbleMenuContainer> {
  @override
  Widget build(BuildContext context) {
    double itemWidth = 60;
    double itemHeight = 40;

    double menuWidth = itemWidth * 2;
    double menuHeight = itemHeight * 2;

    double dx =
        widget.bubbleOffset.dx + (widget.bubbleSize.width - menuWidth) / 2.0;
    double dy = widget.bubbleOffset.dy;

    print("widget.bubbleOffset:${widget.bubbleOffset}");

    print("chatBubbleFrame offset:${widget.bubbleOffset},"
        "size:${widget.bubbleSize}");

    double arrowSize = 10.0;

    return Stack(
      children: [
        Positioned(
          left: dx - arrowSize / 2.0,
          top: dy - menuHeight / 2.0,
          child: buildMenu(
            context,
            Size(itemWidth, itemHeight),
          ),
        ),
        Positioned(
          left: dx + menuWidth / 2 + arrowSize / 2.0,
          top: dy - menuHeight / 2.0 + itemHeight + arrowSize - 2.0,
          child: CustomPaint(
            painter:
                ChatBubbleMenuShape(ColorUtil.hexColor(0x454545), arrowSize),
          ),
        ),
      ],
    );
  }

  Widget buildMenu(BuildContext context, Size itemSize) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0x454545),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(3),
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
      ),
      child: Wrap(
        spacing: 8.0, // 主轴(水平)方向间距
        runSpacing: 4.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        children: [
          ChatBubbleMenuButton(
            width: itemSize.width,
            height: itemSize.height,
            icon: "file://ic_post_unlike.png",
            name: "复制",
            onBubbleMenuButtonPressed: () {
              widget.onBubbleMenuButtonPressed(0);
            },
          ),
          ChatBubbleMenuButton(
            width: itemSize.width,
            height: itemSize.height,
            icon: "file://ic_post_unlike.png",
            name: "删除",
            onBubbleMenuButtonPressed: () {
              widget.onBubbleMenuButtonPressed(1);
            },
          ),
        ],
      ),
    );
  }
}

// 显示气泡菜单
class ChatBubbleMenuButton extends StatelessWidget {
  const ChatBubbleMenuButton({
    Key? key,
    required this.icon,
    required this.name,
    required this.onBubbleMenuButtonPressed,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String icon;
  final String name;
  final Function onBubbleMenuButtonPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      width: width,
      height: height,
      borderRadius: 6.0,
      onPressed: () {
        onBubbleMenuButtonPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildButtonIcon(context),
          SizedBox(
            height: 2.0,
          ),
          Text(
            "${name}",
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: ColorUtil.hexColor(0xffffff),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonIcon(BuildContext context) {
    // 本地图片
    String imageUrl = "${icon ?? ""}";
    String start = "file://";
    if (imageUrl.startsWith(start)) {
      String imageAssetFile = imageUrl.substring(start.length);

      return ImageHelper.wrapAssetAtImages(
        "icons/${imageAssetFile}",
        width: 18.0,
        height: 18.0,
      );
    }

    // 网络图片
    return ImageHelper.imageNetwork(
      imageUrl: imageUrl,
      width: 18.0,
      height: 18.0,
      errorHolder: Container(),
    );
  }
}
