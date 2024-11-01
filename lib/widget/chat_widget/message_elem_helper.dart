import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_menu/chat_bubble_menu_container.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_audio_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_buytogether_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_coupon_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_game_web_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_goods_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_image_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_location_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_poster_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_redpacket_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_text_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_video_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:one_context/one_context.dart';

// 定义Bubble的大小与位置
class ChatBubbleFrame {
  Offset offset;
  Size size;

  ChatBubbleFrame({required this.offset, required this.size});
}

// 根据不同的消息返回不同的element
class MessageElemHelper {
  static Widget layoutCellElem(CommonChatMessage chatMessage) {
    // 文本
    if (CommMessageType.commMessageTypeText == chatMessage.messageType) {
      return ChatCellTextElem(
        chatMessage: chatMessage,
      );
    }

    // 图片
    if (CommMessageType.commMessageTypeImage == chatMessage.messageType) {
      return ChatCellImageElem(
        chatMessage: chatMessage,
      );
    }

    // 视频
    if (CommMessageType.commMessageTypeVideo == chatMessage.messageType) {
      return ChatCellVideoElem(
        chatMessage: chatMessage,
      );
    }

    // 音频
    if (CommMessageType.commMessageTypeAudio == chatMessage.messageType) {
      return ChatCellAudioElem(
        chatMessage: chatMessage,
      );
    }

    // 定位
    if (CommMessageType.commMessageTypeLocation == chatMessage.messageType) {
      return ChatCellLocationElem(
        chatMessage: chatMessage,
      );
    }

    // 分享的Gameweb
    if (CommMessageType.commMessageTypeGameWeb == chatMessage.messageType) {
      return ChatCellGameWebElem(
        chatMessage: chatMessage,
      );
    }

    // 商品
    if (CommMessageType.commMessageTypeGoods == chatMessage.messageType) {
      return ChatCellGoodsElem(
        chatMessage: chatMessage,
      );
    }

    // 分享的券
    if (CommMessageType.commMessageTypeCoupon == chatMessage.messageType) {
      return ChatCellCouponElem(
        chatMessage: chatMessage,
      );
    }

    // 帖子
    if (CommMessageType.commMessageTypePoster == chatMessage.messageType) {
      return ChatCellPosterElem(
        chatMessage: chatMessage,
        onFeedLikePressed: (CommonChatMessage chatMessage) {
          print("PostElem onFeedLikePressed:${chatMessage}");
        },
        onFeedCommentPressed: (CommonChatMessage chatMessage) {
          print("PostElem onFeedCommentPressed:${chatMessage}");
        },
      );
    }

    // 红包
    if (CommMessageType.commMessageTypeRedPacket == chatMessage.messageType) {
      return ChatCellRedPacketElem(
        chatMessage: chatMessage,
      );
    }

    // 拼团
    if (CommMessageType.commMessageTypeBuyTogether == chatMessage.messageType) {
      return ChatCellBuyTogetherElem(
        chatMessage: chatMessage,
      );
    }

    return Container();
  }

  static Color? layoutElemBubbleColor(CommonChatMessage chatMessage) {
    // 文本
    if (CommMessageType.commMessageTypeText == chatMessage.messageType) {
      return null;
    }

    // 图片
    if (CommMessageType.commMessageTypeImage == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 视频
    if (CommMessageType.commMessageTypeVideo == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 音频
    if (CommMessageType.commMessageTypeAudio == chatMessage.messageType) {
      return null;
    }

    // 定位
    if (CommMessageType.commMessageTypeLocation == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 分享的Gameweb
    if (CommMessageType.commMessageTypeGameWeb == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 商品
    if (CommMessageType.commMessageTypeGoods == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 分享的券
    if (CommMessageType.commMessageTypeCoupon == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 帖子
    if (CommMessageType.commMessageTypePoster == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 红包
    if (CommMessageType.commMessageTypeRedPacket == chatMessage.messageType) {
      return Colors.transparent;
    }

    // 拼团
    if (CommMessageType.commMessageTypeBuyTogether == chatMessage.messageType) {
      return Colors.transparent;
    }

    return null;
  }

  // 气泡单击操作
  static void elemBubbleTap(BuildContext context, CommonChatMessage chatMessage,
      {Map<String, dynamic>? additionalArguments}) {
    // 文本
    if (CommMessageType.commMessageTypeText == chatMessage.messageType) {
      // 复制文本
      return;
    }

    // 图片
    if (CommMessageType.commMessageTypeImage == chatMessage.messageType) {
      List<String> images = [chatMessage.imageUrl!];
      int index = 0;
      // 图片预览
      return;
    }

    // 视频
    if (CommMessageType.commMessageTypeVideo == chatMessage.messageType) {
      return;
    }

    // 音频
    if (CommMessageType.commMessageTypeAudio == chatMessage.messageType) {
      return;
    }

    // 定位
    if (CommMessageType.commMessageTypeLocation == chatMessage.messageType) {
      return;
    }

    // 分享的Gameweb
    if (CommMessageType.commMessageTypeGameWeb == chatMessage.messageType) {
      return;
    }

    // 商品
    if (CommMessageType.commMessageTypeGoods == chatMessage.messageType) {
      return;
    }

    // 分享的券
    if (CommMessageType.commMessageTypeCoupon == chatMessage.messageType) {
      return;
    }

    // 帖子
    if (CommMessageType.commMessageTypePoster == chatMessage.messageType) {
      String feedId = chatMessage.postFeedId ?? "";
      Map<String, dynamic> arguments = {};
      if (additionalArguments != null) {
        arguments.addAll(additionalArguments);
      }
      arguments["feedId"] = feedId;
      // 跳转到帖子
      return;
    }

    // 红包
    if (CommMessageType.commMessageTypeRedPacket == chatMessage.messageType) {
      return;
    }

    // 拼团
    if (CommMessageType.commMessageTypeBuyTogether == chatMessage.messageType) {
      return;
    }

    return;
  }

  // 气泡双击操作
  static void elemBubbleDoubleTap(
      BuildContext context, CommonChatMessage chatMessage,
      {Map<String, dynamic>? additionalArguments}) {
    // 文本
    if (CommMessageType.commMessageTypeText == chatMessage.messageType) {
      return;
    }

    // 图片
    if (CommMessageType.commMessageTypeImage == chatMessage.messageType) {
      return;
    }

    // 视频
    if (CommMessageType.commMessageTypeVideo == chatMessage.messageType) {
      return;
    }

    // 音频
    if (CommMessageType.commMessageTypeAudio == chatMessage.messageType) {
      return;
    }

    // 定位
    if (CommMessageType.commMessageTypeLocation == chatMessage.messageType) {
      return;
    }

    // 分享的Gameweb
    if (CommMessageType.commMessageTypeGameWeb == chatMessage.messageType) {
      return;
    }

    // 商品
    if (CommMessageType.commMessageTypeGoods == chatMessage.messageType) {
      return;
    }

    // 分享的券
    if (CommMessageType.commMessageTypeCoupon == chatMessage.messageType) {
      return;
    }

    // 帖子
    if (CommMessageType.commMessageTypePoster == chatMessage.messageType) {
      return;
    }

    // 红包
    if (CommMessageType.commMessageTypeRedPacket == chatMessage.messageType) {
      return;
    }

    // 拼团
    if (CommMessageType.commMessageTypeBuyTogether == chatMessage.messageType) {
      return;
    }

    return;
  }

  // 气泡长按操作
  static void elemBubbleLongPress(
      BuildContext context, CommonChatMessage chatMessage,
      {Map<String, dynamic>? additionalArguments,
      required LongPressStartDetails details,
      ChatBubbleFrame? chatBubbleFrame}) {
    if (ChatBubbleFrame == null) {
      // 没有气泡大小的时候
      return;
    }

    Offset bubbleOffset = chatBubbleFrame!.offset;
    Size bubbleSize = chatBubbleFrame!.size;

    print("chatBubbleFrame offset:${chatBubbleFrame.offset},"
        "size:${chatBubbleFrame.size}");

    // 气泡长按弹出菜单
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.0),
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      pageBuilder: (BuildContext dialogContext, Animation animation,
          Animation secondaryAnimation) {
        return GestureDetector(
          child: ChatBubbleMenuContainer(
            chatMessage: chatMessage,
            bubbleOffset: bubbleOffset,
            bubbleSize: bubbleSize,
            onBubbleMenuButtonPressed: (int index) {
              Navigator.of(dialogContext).pop();
            },
          ),
          onTapDown: (TapDownDetails details) {
            Navigator.of(dialogContext).pop();
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: anim,
          child: child,
        );
      },
    );

    // 文本
    if (CommMessageType.commMessageTypeText == chatMessage.messageType) {
      return;
    }

    // 图片
    if (CommMessageType.commMessageTypeImage == chatMessage.messageType) {
      return;
    }

    // 视频
    if (CommMessageType.commMessageTypeVideo == chatMessage.messageType) {
      return;
    }

    // 音频
    if (CommMessageType.commMessageTypeAudio == chatMessage.messageType) {
      return;
    }

    // 定位
    if (CommMessageType.commMessageTypeLocation == chatMessage.messageType) {
      return;
    }

    // 分享的Gameweb
    if (CommMessageType.commMessageTypeGameWeb == chatMessage.messageType) {
      return;
    }

    // 商品
    if (CommMessageType.commMessageTypeGoods == chatMessage.messageType) {
      return;
    }

    // 分享的券
    if (CommMessageType.commMessageTypeCoupon == chatMessage.messageType) {
      return;
    }

    // 帖子
    if (CommMessageType.commMessageTypePoster == chatMessage.messageType) {
      return;
    }

    // 红包
    if (CommMessageType.commMessageTypeRedPacket == chatMessage.messageType) {
      return;
    }

    // 拼团
    if (CommMessageType.commMessageTypeBuyTogether == chatMessage.messageType) {
      return;
    }

    return;
  }
}
