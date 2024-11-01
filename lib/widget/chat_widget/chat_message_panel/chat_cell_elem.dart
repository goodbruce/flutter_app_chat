import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_time_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/received_message_screen.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/send_messsage_screen.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/widget/chat_widget/message_elem_helper.dart';

// 基础类
class ChatCellElem extends StatefulWidget {
  const ChatCellElem({
    Key? key,
    required this.childElem,
    required this.chatMessage,
    required this.onSendFailedIndicatorPressed,
    this.onBubbleTapPressed,
    this.onBubbleDoubleTapPressed,
    this.onBubbleLongPressed,
  }) : super(key: key);

  final Widget childElem;
  final CommonChatMessage chatMessage;
  final Function(CommonChatMessage chatMessage) onSendFailedIndicatorPressed;
  final Function(CommonChatMessage chatMessage)? onBubbleTapPressed;
  final Function(CommonChatMessage chatMessage)? onBubbleDoubleTapPressed;
  final Function(CommonChatMessage chatMessage, LongPressStartDetails details,
      ChatBubbleFrame? chatBubbleFrame)? onBubbleLongPressed;

  @override
  State<ChatCellElem> createState() => _ChatCellElemState();
}

class _ChatCellElemState extends State<ChatCellElem> {
  final GlobalKey bubbleKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 获取气泡的大小
  ChatBubbleFrame? getBubbleFrame(BuildContext context) {
    if (bubbleKey.currentContext == null) return null;
    // 获取输入框的位置
    final renderObject =
        bubbleKey.currentContext!.findRenderObject() as RenderBox;
    if (renderObject == null) return null;

    // offset.dx , offset.dy 就是控件的左上角坐标
    Offset offset = renderObject.localToGlobal(Offset.zero);
    //获取size
    Size size = renderObject.size;

    return ChatBubbleFrame(offset: offset, size: size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTime(context),
          buildUserAuthor(context),
          buildBubble(context),
        ],
      ),
    );
  }

  Widget buildUserAuthor(BuildContext context) {
    if (CommMessageFromType.commMessageFromTypeOutgoing ==
        widget.chatMessage.messageFromType) {
      return buildSendAuthor(context);
    }

    if (CommMessageFromType.commMessageFromTypeReceiving ==
        widget.chatMessage.messageFromType) {
      return buildReceivedAuthor(context);
    }

    return Container();
  }

  Widget buildBubble(BuildContext context) {
    if (CommMessageFromType.commMessageFromTypeOutgoing ==
        widget.chatMessage.messageFromType) {
      SendMessageIndicatorType indicatorType = SendMessageIndicatorType.none;
      if (CommMessageStatus.commMessageStatusSending ==
          widget.chatMessage.messageStatus) {
        indicatorType = SendMessageIndicatorType.sending;
      } else if (CommMessageStatus.commMessageStatusFailed ==
          widget.chatMessage.messageStatus) {
        indicatorType = SendMessageIndicatorType.sendFailed;
      }

      return GestureDetector(
        onTap: () {
          if (widget.onBubbleTapPressed != null) {
            widget.onBubbleTapPressed!(widget.chatMessage);
          }
        },
        onDoubleTap: () {
          if (widget.onBubbleDoubleTapPressed != null) {
            widget.onBubbleDoubleTapPressed!(widget.chatMessage);
          }
        },
        onLongPressStart: (LongPressStartDetails details) {
          if (widget.onBubbleLongPressed != null) {
            widget.onBubbleLongPressed!(
                widget.chatMessage, details, getBubbleFrame(context));
          }
        },
        child: SentMessageScreen(
          child: widget.childElem,
          color: MessageElemHelper.layoutElemBubbleColor(widget.chatMessage),
          indicatorType: indicatorType,
          onSendFailedIndicatorPressed: () {
            widget.onSendFailedIndicatorPressed(widget.chatMessage);
          },
          messageScreenKey: bubbleKey,
        ),
      );
    }

    if (CommMessageFromType.commMessageFromTypeReceiving ==
        widget.chatMessage.messageFromType) {
      return GestureDetector(
        onTap: () {
          if (widget.onBubbleTapPressed != null) {
            widget.onBubbleTapPressed!(widget.chatMessage);
          }
        },
        onDoubleTap: () {
          if (widget.onBubbleDoubleTapPressed != null) {
            widget.onBubbleDoubleTapPressed!(widget.chatMessage);
          }
        },
        onLongPressStart: (LongPressStartDetails details) {
          if (widget.onBubbleLongPressed != null) {
            widget.onBubbleLongPressed!(
                widget.chatMessage, details, getBubbleFrame(context));
          }
        },
        child: ReceivedMessageScreen(
          child: widget.childElem,
          color: MessageElemHelper.layoutElemBubbleColor(widget.chatMessage),
          messageScreenKey: bubbleKey,
        ),
      );
    }

    return Container(
      child: widget.childElem,
    );
  }

  Widget buildSendAuthor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: buildUserName(context),
        ),
        SizedBox(
          width: 10.0,
        ),
        buildAvatar(context),
        SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  Widget buildReceivedAuthor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 10.0,
        ),
        buildAvatar(context),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: buildUserName(context),
        ),
      ],
    );
  }

  Widget buildUserName(BuildContext context) {
    TextAlign? textAlign;
    if (CommMessageFromType.commMessageFromTypeOutgoing ==
        widget.chatMessage.messageFromType) {
      textAlign = TextAlign.right;
    }

    if (CommMessageFromType.commMessageFromTypeReceiving ==
        widget.chatMessage.messageFromType) {
      textAlign = TextAlign.left;
    }

    return Text(
      "${widget.chatMessage.userName}",
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: ColorUtil.hexColor(0x444444),
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget buildAvatar(BuildContext context) {
    if (widget.chatMessage.userAvatar != null &&
        widget.chatMessage.userAvatar!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
        child: ImageHelper.imageNetwork(
          imageUrl: "${widget.chatMessage.userAvatar}",
          fit: BoxFit.cover,
          width: 44.0,
          height: 44.0,
          placeholder: ImageHelper.wrapAssetAtImages(
            "icons/ic_avatar_default.png",
            fit: BoxFit.cover,
            width: 44.0,
            height: 44.0,
          ),
          errorHolder: ImageHelper.wrapAssetAtImages(
            "icons/ic_avatar_default.png",
            fit: BoxFit.cover,
            width: 44.0,
            height: 44.0,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(22.0)),
      child: ImageHelper.wrapAssetAtImages(
        "icons/ic_avatar_default.png",
        fit: BoxFit.cover,
        width: 44.0,
        height: 44.0,
      ),
    );
  }

  // 显示时间
  Widget buildTime(BuildContext context) {
    if (CommMessageType.commMessageTypeTips == widget.chatMessage.messageType) {
      return Container();
    }

    if (widget.chatMessage.displayTime == true) {
      return ChatCellTimeElem(timeString: widget.chatMessage.timeString ?? "");
    }

    return Container();
  }
}

// 发送状态指示器
class ChatCellSendingIndicator extends StatelessWidget {
  const ChatCellSendingIndicator({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        color: ColorUtil.hexColor(0x333333),
      ),
    );
  }
}
