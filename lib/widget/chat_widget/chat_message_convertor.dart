import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:flutter_app_chat/network/message_constant.dart';
import 'package:flutter_app_chat/utils/time_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_custom_msgcontent.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 消息转换
class ChatMessageConvertor {
  static CommonChatMessage createTextMessage(String text, UserModel userModel) {
    //获取当前时间的毫秒数
    int nowDateSeconds = (DateTime.now().millisecondsSinceEpoch / 1000).truncate();

    CommonChatMessage chatMessage = CommonChatMessage();
    chatMessage.userId = userModel.user?.userId;
    chatMessage.userName = userModel.user?.nickName;
    chatMessage.userAvatar = userModel.user?.avatar;

    chatMessage.displayTime = true;
    chatMessage.timeString = TimeUtil.timeFormatterChatTimeStamp(nowDateSeconds);
    chatMessage.formatterSeconds = "${nowDateSeconds}";
    chatMessage.messageType = CommMessageType.commMessageTypeText;
    chatMessage.messageFromType =
        CommMessageFromType.commMessageFromTypeOutgoing;

    chatMessage.text = text;

    Map<String, dynamic>? dict = jsonDecode(text);
    if (dict != null && dict.isNotEmpty) {
      String? msgType = "${dict["msgType"]}";
      // 文本
      if (kMsgTypeText == msgType) {
        CommCustomTextMsgContent textModel =
            CommCustomTextMsgContent.fromJson(dict);
        chatMessage.msgContentModel = textModel;

        chatMessage.messageType = CommMessageType.commMessageTypeText;
        chatMessage.text = textModel.message;
        if (true == textModel.systemMsg) {
          chatMessage.text = textModel.content;
          chatMessage.userAvatar = textModel.sendUserAvatar;
          chatMessage.userName = textModel.sendUserName;
        }
      }
    }

    return chatMessage;
  }

  // 获取历史消息Message
  static Future<List<CommonChatMessage>> getGroupHistoryMessageList({
    required String groupID,
    required int count,
    String? lastMsgID,
  }) async {
    List<CommonChatMessage> chatMessages = [];
    List<CommonChatMessage> tmpMessages = createMessageList();
    chatMessages.addAll(tmpMessages);

    return chatMessages;
  }

  // 模拟演示数据
  static List<CommonChatMessage> createMessageList() {
    List<CommonChatMessage> messageList = [];
    int baseIndex = 30;
    for (int index = 0; index < 10; index++) {
      CommonChatMessage chatMessage = CommonChatMessage();
      chatMessage.formatterSeconds = "${DateUtil.getNowDateMs()}";
      chatMessage.timeString = TimeUtil.timeFormatterChatTimeStamp(int.parse(chatMessage.formatterSeconds ?? ""));
      chatMessage.userId = "110";
      chatMessage.userName = "用户COCo";
      chatMessage.userAvatar =
          "https://c-ssl.dtstatic.com/uploads/blog/202208/01/20220801091937_fc599.thumb.400_0.jpeg";

      chatMessage.displayTime = true;
      chatMessage.timeString = "12:50";
      chatMessage.messageType = CommMessageType.commMessageTypeText;

      if (index % 2 == 0) {
        chatMessage.messageFromType =
            CommMessageFromType.commMessageFromTypeOutgoing;
      } else {
        chatMessage.messageFromType =
            CommMessageFromType.commMessageFromTypeReceiving;
      }

      if (index % baseIndex == 1) {
        chatMessage.text = "[偷笑] 简单的东西往往能带给人们的是更多的享受";
      } else if (index % baseIndex == 2) {
        chatMessage.text =
            "屋檐如悬崖 [棒棒糖] 风铃如沧海 我等燕归来 时间被安排 [棒棒糖] 演一场意外 你悄然走开 故事在城外 [棒棒糖] 浓雾散不开 看不清对白";
      } else if (index % baseIndex == 3) {
        chatMessage.text = "精要主义：Less is more!!!";
      } else if (index % baseIndex == 4) {
        chatMessage.messageType = CommMessageType.commMessageTypeImage;
        chatMessage.imageUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202108/06/20210806160614_a62ea.thumb.1000_0.jpg";
        chatMessage.imageSize = Size(460, 815);
      } else if (index % baseIndex == 5) {
        chatMessage.messageType = CommMessageType.commMessageTypeGameWeb;
        chatMessage.gShareImageUrl =
            "https://c-ssl.dtstatic.com/uploads/item/201902/05/20190205225429_rnY4M.thumb.1000_0.jpeg";
        chatMessage.gWebTitle = "送好礼了，一起来商场玩大富翁！";
        chatMessage.gWebContent = "我的运气已抵达火星，不要太羡慕，你也可以拥有！";
      } else if (index % baseIndex == 6) {
        chatMessage.messageType = CommMessageType.commMessageTypeGoods;
        chatMessage.goodsImageUrl =
            "https://c-ssl.dtstatic.com/uploads/item/201902/05/20190205225429_rnY4M.thumb.1000_0.jpeg";
        chatMessage.goodsTitle = "星巴克中杯测试拿铁一杯";
        chatMessage.showGoodsPrice = "50.00";
      } else if (index % baseIndex == 7) {
        chatMessage.messageType = CommMessageType.commMessageTypeCoupon;
        chatMessage.couponShareImageUrl =
            "https://c-ssl.dtstatic.com/uploads/item/201902/05/20190205225429_rnY4M.thumb.1000_0.jpeg";
        chatMessage.couponTitle = "送你脸脸购物中心";
        chatMessage.couponContent = "宝马mini小奖品-换购券";
      } else if (index % baseIndex == 8) {
        chatMessage.messageType = CommMessageType.commMessageTypePoster;
        chatMessage.postContent = "我在这里发了一个动态帖子，你也来试试～";
        chatMessage.showLikeNum = "13";
        chatMessage.showCommentNum = "7";
        List<CommonChatMessagePosterImage> postImages = [];
        for (int index = 0; index < 6; index++) {
          CommonChatMessagePosterImage image = CommonChatMessagePosterImage();
          if (0 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195506_cdc12.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (1 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_8a190.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (2 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_e5fe5.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (3 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195512_42d48.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (4 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195514_c04f2.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (5 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195516_28f6e.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          }
          postImages.add(image);
        }
        chatMessage.postImages = postImages;
      } else if (index % baseIndex == 15) {
        chatMessage.messageType = CommMessageType.commMessageTypePoster;
        chatMessage.postContent = "我在这里发了一个动态帖子，你也来试试～";
        chatMessage.showLikeNum = "13";
        chatMessage.showCommentNum = "7";
        List<CommonChatMessagePosterImage> postImages = [];
        for (int index = 0; index < 1; index++) {
          CommonChatMessagePosterImage image = CommonChatMessagePosterImage();
          if (0 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195506_cdc12.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (1 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_8a190.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (2 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_e5fe5.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (3 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195512_42d48.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (4 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195514_c04f2.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (5 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195516_28f6e.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          }
          postImages.add(image);
        }
        chatMessage.postImages = postImages;
      } else if (index % baseIndex == 9) {
        chatMessage.messageType = CommMessageType.commMessageTypeImage;
        chatMessage.imageSize = Size(120, 120);
        chatMessage.isGif = true;
        chatMessage.imageUrl = "file://common/gif_02.gif";
      } else if (index % baseIndex == 10) {
        chatMessage.messageType = CommMessageType.commMessageTypeVideo;
        chatMessage.videoThumbImageUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202108/06/20210806160614_a62ea.thumb.1000_0.jpg";
        chatMessage.videoThumbImageSize = Size(575, 866);
      } else if (index % baseIndex == 11) {
        chatMessage.messageType = CommMessageType.commMessageTypeAudio;
        chatMessage.audioUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202108/06/20210806160614_a62ea.thumb.1000_0.jpg";
        chatMessage.duration = "36";
      } else if (index % baseIndex == 12) {
        chatMessage.messageType = CommMessageType.commMessageTypeAudio;
        chatMessage.audioUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202108/06/20210806160614_a62ea.thumb.1000_0.jpg";
        chatMessage.duration = "8";
      } else if (index % baseIndex == 13) {
        chatMessage.messageType = CommMessageType.commMessageTypeLocation;
        chatMessage.longitude = 117.1866210000;
        chatMessage.latitude = 36.6806250000;
        chatMessage.locationInfo = "浙江省杭州市余杭区欧美金融城美国中心";
      } else if (index % baseIndex == 14) {
        chatMessage.messageType = CommMessageType.commMessageTypeRedPacket;
        chatMessage.redPacketTitle = "520网络情人节，惊喜的一天，嘻嘻";
        chatMessage.redPacketStatus = "已被领完";
      } else if (index % baseIndex == 17) {
        chatMessage.messageType = CommMessageType.commMessageTypeImage;
        chatMessage.imageSize = Size(120, 120);
        chatMessage.isGif = true;
        chatMessage.imageUrl = "file://common/gif_01.gif";
      } else if (index % baseIndex == 18) {
        chatMessage.messageType = CommMessageType.commMessageTypeImage;
        chatMessage.imageSize = Size(120, 120);
        chatMessage.isGif = true;
        chatMessage.imageUrl = "file://common/gif_03.gif";
      } else if (index % baseIndex == 19) {
        chatMessage.messageType = CommMessageType.commMessageTypeRedPacket;
        chatMessage.redPacketTitle = "520网络情人节，惊喜的一天，嘻嘻";
        chatMessage.redPacketStatus = "已被领完";
      } else if (index % baseIndex == 20) {
        chatMessage.messageType = CommMessageType.commMessageTypeBuyTogether;
        chatMessage.ptGoodsImageUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202107/26/20210726092648_31ef1.thumb.1000_0.jpeg";
        chatMessage.ptGoodsTitle = "星巴克中杯测试冰淇淋一杯套餐";
        chatMessage.ptGoodsCurrentPrice = "99.00";
        chatMessage.ptGoodsOriginPrice = "199.00";
      } else if (index % baseIndex == 21) {
        chatMessage.messageType = CommMessageType.commMessageTypeRedPacket;
        chatMessage.redPacketTitle = "520网络情人节，惊喜的一天，嘻嘻";
        chatMessage.redPacketStatus = "已被领完";
      } else if (index % baseIndex == 25) {
        chatMessage.messageType = CommMessageType.commMessageTypeBuyTogether;
        chatMessage.ptGoodsImageUrl =
            "https://c-ssl.dtstatic.com/uploads/blog/202107/26/20210726092648_31ef1.thumb.1000_0.jpeg";
        chatMessage.ptGoodsTitle = "星巴克中杯测试冰淇淋一杯套餐";
        chatMessage.ptGoodsCurrentPrice = "99.00";
        chatMessage.ptGoodsOriginPrice = "199.00";
      } else if (index % baseIndex == 26) {
        chatMessage.messageType = CommMessageType.commMessageTypePoster;
        chatMessage.postContent = "我在这里发了一个动态帖子，你也来试试～";
        chatMessage.showLikeNum = "13";
        chatMessage.showCommentNum = "7";
        List<CommonChatMessagePosterImage> postImages = [];
        for (int index = 0; index < 4; index++) {
          CommonChatMessagePosterImage image = CommonChatMessagePosterImage();
          if (0 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195506_cdc12.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (1 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_8a190.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (2 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195508_e5fe5.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (3 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195512_42d48.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (4 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195514_c04f2.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          } else if (5 == index) {
            image.imageUrl =
                "https://c-ssl.dtstatic.com/uploads/blog/202205/09/20220509195516_28f6e.thumb.1000_0.jpeg_webp";
            image.imageSize = Size(450, 866);
          }
          postImages.add(image);
        }
        chatMessage.postImages = postImages;
      } else if (index % baseIndex == 27) {
        chatMessage.messageType = CommMessageType.commMessageTypeCoupon;
        chatMessage.couponShareImageUrl =
            "https://c-ssl.dtstatic.com/uploads/item/201902/05/20190205225429_rnY4M.thumb.1000_0.jpeg";
        chatMessage.couponTitle = "送你脸脸购物中心";
        chatMessage.couponContent = "RAY妆蕾金色面膜一盒礼券";
      } else if (index % baseIndex == 28) {
        chatMessage.messageType = CommMessageType.commMessageTypeCoupon;
        chatMessage.couponShareImageUrl =
            "https://c-ssl.dtstatic.com/uploads/item/201902/05/20190205225429_rnY4M.thumb.1000_0.jpeg";
        chatMessage.couponTitle = "送你脸脸购物中心";
        chatMessage.couponContent = "RAY妆蕾金色面膜一盒礼券";
      } else {
        chatMessage.text = "[偷笑]简单!";
      }

      messageList.add(chatMessage);
    }
    return messageList;
  }

  // 将IMMessage转换成展示使用的CommChatMessage类
  static Future<CommonChatMessage?> createChatMessageByV2IMMessage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastMessageTime = prefs.getString(kLastMessageTimeKey);
    // CommonChatMessage model = CommonChatMessage();
    List<CommonChatMessage> tmpMessages = createMessageList();
    CommonChatMessage aMsg = tmpMessages[Random().nextInt(tmpMessages.length)];
    return aMsg;

    // String? nickName = message.nickName;
    // if (!(nickName != null && nickName!.isNotEmpty)) {
    //   nickName = message.sender;
    // }
    //
    // model.displayTime = false;
    // model.userAvatar = message.faceUrl;
    // model.userName = "${nickName ?? ""}";
    // model.userId = message.sender;
    // model.msgID = message.msgID;
    //
    // model.imMessage = message;
    // if (!(model.userName != null && model.userName!.isNotEmpty)) {
    //   model.userName = "${message.nameCard ?? ""}";
    // }
    //
    // model.formatterSeconds = "${message.timestamp}";
    // model.timeString = TimeUtil.timeFormatterChatTimeStamp(int.parse(model.formatterSeconds ?? ""));
    //
    // // 消息状态
    // switch (message.status) {
    //   case MessageStatus.V2TIM_MSG_STATUS_SENDING:
    //     {
    //       model.messageStatus = CommMessageStatus.commMessageStatusSending;
    //       break;
    //     }
    //   case MessageStatus.V2TIM_MSG_STATUS_SEND_SUCC:
    //     {
    //       model.messageStatus = CommMessageStatus.commMessageStatusSuccess;
    //       break;
    //     }
    //   case MessageStatus.V2TIM_MSG_STATUS_SEND_FAIL:
    //     {
    //       model.messageStatus = CommMessageStatus.commMessageStatusFailed;
    //       break;
    //     }
    //   case MessageStatus.V2TIM_MSG_STATUS_HAS_DELETED:
    //     {
    //       model.messageStatus = CommMessageStatus.commMessageStatusDeleted;
    //       break;
    //     }
    //   case MessageStatus.V2TIM_MSG_STATUS_LOCAL_REVOKED:
    //     {
    //       model.messageStatus = CommMessageStatus.commMessageStatusLocalRevoked;
    //       break;
    //     }
    //
    //   default:
    //     break;
    // }
    //
    // // 处理时间
    // print("formatterSeconds:${lastTimeSeconds},"
    //     "message.timestamp:${message.timestamp}");
    // if (!(lastTimeSeconds != null && lastTimeSeconds.isNotEmpty)) {
    //   model.displayTime = true;
    //   lastTimeSeconds = model.formatterSeconds;
    //   await ChatIMManager()
    //       .saveLastMessageTime(kLastMessageTimeKey, lastTimeSeconds ?? "");
    // } else {
    //   int diff =
    //       int.parse(model.formatterSeconds!) - int.parse(lastTimeSeconds);
    //
    //   print("diff:${diff}");
    //
    //   bool displayTime = false;
    //   if (diff.abs() >= 3 * 60) {
    //     displayTime = true;
    //   } else {
    //     displayTime = false;
    //   }
    //
    //   model.displayTime = displayTime;
    //
    //   if (displayTime) {
    //     lastTimeSeconds = model.formatterSeconds;
    //     await ChatIMManager()
    //         .saveLastMessageTime(kLastMessageTimeKey, lastTimeSeconds ?? "");
    //   }
    // }
    //
    // model.conversationType = CommConversationType.commConversationTypeGroup;
    //
    // if (message.isSelf != null && true == message.isSelf) {
    //   model.messageFromType = CommMessageFromType.commMessageFromTypeOutgoing;
    //   // model.userName = [DFSessionManager shareInstance].userModel.name;
    //   // model.userAvatar = [DFSessionManager shareInstance].userModel.avatar;
    // } else {
    //   model.messageFromType = CommMessageFromType.commMessageFromTypeReceiving;
    // }
    //
    // if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_TEXT) {
    //   LoggerManager()
    //       .debug("messageModelFromIMMessage text:${message.textElem?.text}");
    //   bool customText = await exchangedTextMessage(model, message);
    //   if (!customText) {
    //     // 不是自定义，则默认显示
    //     model.messageType = CommMessageType.commMessageTypeText;
    //     model.text = message.textElem?.text;
    //   }
    // } else if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_IMAGE) {
    //   model.messageType = CommMessageType.commMessageTypeImage;
    //
    //   if (message.imageElem != null &&
    //       message.imageElem!.imageList != null &&
    //       message.imageElem!.imageList!.isNotEmpty) {
    //     for (V2TimImage? imImage in message.imageElem!.imageList!) {
    //       if (imImage != null) {
    //         if (V2TIM_IMAGE_TYPE.V2TIM_IMAGE_TYPE_THUMB == imImage.type) {
    //           int? width = imImage.width;
    //           int? height = imImage.height;
    //           model.imageUrl = imImage.url;
    //           model.imageSize =
    //               Size((height ?? 300).toDouble(), (height ?? 300).toDouble());
    //         } else if (V2TIM_IMAGE_TYPE.V2TIM_IMAGE_TYPE_ORIGIN ==
    //             imImage.type) {
    //           model.originImageUrl = imImage.url;
    //         }
    //       }
    //     }
    //   } else {
    //     model.imageUrl = message.imageElem?.path;
    //     model.originImageUrl = message.imageElem?.path;
    //     String filePath = message.imageElem?.path ?? "";
    //     model.imageSize = Size(300, 300);
    //   }
    // } else if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_GROUP_TIPS) {
    //   model.messageType = CommMessageType.commMessageTypeTips;
    //
    //   return null;
    // }

    // return model;
  }

  static Future<bool> exchangedTextMessage(
      CommonChatMessage model) async {
    return true;
    // try {
    //   String? textInfo = imMessage.textElem?.text;
    //   if (textInfo != null && textInfo.isNotEmpty) {
    //     Map<String, dynamic>? dict = jsonDecode(textInfo);
    //     if (dict != null && dict.isNotEmpty) {
    //       String? msgType = "${dict["msgType"]}";
    //       // 文本
    //       if (kMsgTypeText == msgType) {
    //         CommCustomTextMsgContent textModel =
    //             CommCustomTextMsgContent.fromJson(dict);
    //         model.msgContentModel = textModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeText;
    //         model.text = textModel.message;
    //         if (true == textModel.systemMsg) {
    //           model.text = textModel.content;
    //           model.userAvatar = textModel.sendUserAvatar;
    //           model.userName = textModel.sendUserName;
    //         }
    //
    //         return true;
    //       }
    //
    //       // 图片
    //       if (kMsgTypeImage == msgType) {
    //         CommCustomImageMsgContent imageModel =
    //             CommCustomImageMsgContent.fromJson(dict);
    //         model.msgContentModel = imageModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeImage;
    //         model.imageUrl = imageModel.imageUrl;
    //         model.originImageUrl = imageModel.imageUrl;
    //         model.imageSize = Size(300, 300);
    //
    //         return true;
    //       }
    //
    //       // 视频
    //       if (kMsgTypeVideo == msgType) {
    //         CommCustomVideoMsgContent videoModel =
    //             CommCustomVideoMsgContent.fromJson(dict);
    //         model.msgContentModel = videoModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeVideo;
    //         model.videoThumbImageUrl =
    //             "https://c-ssl.dtstatic.com/uploads/blog/202108/06/20210806160614_a62ea.thumb.1000_0.jpg";
    //         model.videoThumbImageSize = Size(575, 866);
    //
    //         return true;
    //       }
    //
    //       // 表情符号
    //       if (kMsgTypeEmoji == msgType) {
    //         CommCustomEmojiMsgContent emojiModel =
    //             CommCustomEmojiMsgContent.fromJson(dict);
    //         model.msgContentModel = emojiModel;
    //
    //         return true;
    //       }
    //
    //       // 分享的游戏地址等
    //       if (kMsgTypeAppLink == msgType) {
    //         CommCustomAppLinkMsgContent appLinkModel =
    //             CommCustomAppLinkMsgContent.fromJson(dict);
    //         model.msgContentModel = appLinkModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeGameWeb;
    //         model.gShareImageUrl = appLinkModel.shareImage;
    //         model.gWebTitle = appLinkModel.shareTitle;
    //         model.gWebContent = appLinkModel.shareIntro;
    //
    //         if (true == appLinkModel.systemMsg) {
    //           model.userAvatar = appLinkModel.sendUserAvatar;
    //           model.userName = appLinkModel.sendUserName;
    //         }
    //
    //         return true;
    //       }
    //
    //       // 帖子
    //       if (kMsgTypeFeed == msgType) {
    //         CommCustomFeedMsgContent postFeedModel =
    //             CommCustomFeedMsgContent.fromJson(dict);
    //         model.msgContentModel = postFeedModel;
    //
    //         model.postFeedId = "${postFeedModel.feedId ?? ""}";
    //         model.messageType = CommMessageType.commMessageTypePoster;
    //         model.postContent = postFeedModel.content;
    //         model.liked = postFeedModel.liked ?? false;
    //         model.showLikeNum = "${postFeedModel.likedCount ?? "0"}";
    //         model.showCommentNum = "${postFeedModel.commentCount ?? "0"}";
    //         List<CommonChatMessagePosterImage> postImages = [];
    //         if (postFeedModel.images != null &&
    //             postFeedModel.images!.isNotEmpty) {
    //           for (int index = 0;
    //               index < postFeedModel.images!.length;
    //               index++) {
    //             String imageUrl = postFeedModel.images![index];
    //             CommonChatMessagePosterImage image =
    //                 CommonChatMessagePosterImage();
    //             image.imageUrl = imageUrl;
    //             image.imageSize = Size(300, 300);
    //             postImages.add(image);
    //           }
    //         }
    //
    //         model.postImages = postImages;
    //
    //         return true;
    //       }
    //
    //       // 券
    //       if (kMsgTypeCoupon == msgType) {
    //         CommCustomCouponMsgContent couponModel =
    //             CommCustomCouponMsgContent.fromJson(dict);
    //         model.msgContentModel = couponModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeCoupon;
    //         model.couponShareImageUrl = couponModel.backgroundImg;
    //         model.couponTitle = "送你${couponModel.shopName}";
    //         model.couponContent = "${couponModel.couponName ?? ""}";
    //
    //         return true;
    //       }
    //
    //       // 分享的商品
    //       if (kMsgTypeGoods == msgType) {
    //         CommCustomGoodsMsgContent goodsModel =
    //             CommCustomGoodsMsgContent.fromJson(dict);
    //         model.msgContentModel = goodsModel;
    //
    //         model.messageType = CommMessageType.commMessageTypeGoods;
    //         model.goodsImageUrl = goodsModel.image;
    //         model.goodsTitle = goodsModel.title;
    //         model.showGoodsPrice = "${goodsModel.price}";
    //
    //         if (true == goodsModel.systemMsg) {
    //           model.userAvatar = goodsModel.sendUserAvatar;
    //           model.userName = goodsModel.sendUserName;
    //         }
    //
    //         return true;
    //       }
    //
    //       // 券领取
    //       if (kMsgTypeCouponReceive == msgType) {
    //         String? currentUser = await ChatIMManager().getCurrentUser();
    //         String toAccount = "${dict["toAccount"]}";
    //         if (toAccount == currentUser) {
    //           // 如果发给的是当前用户
    //         } else {
    //           model.messageType = CommMessageType.commMessageTypeTips;
    //           String fromAppId = "${dict["fromAppId"]}";
    //           String name = "${dict["name"]}";
    //           if ("71" == fromAppId) {
    //             model.tipsContentText = "${name}成功参与了两元店游戏";
    //           }
    //
    //           return true;
    //         }
    //
    //         // 群系统通知消息
    //         if (kMsgTypeGroupNotice == msgType) {
    //           model.messageType = CommMessageType.commMessageTypeTips;
    //
    //           return true;
    //         }
    //       }
    //     }
    //   }
    // } catch (e) {
    //   // 可以捕获任意异常
    //   print("exchangedTextMessage exception:${e.toString()}");
    //   return false;
    // }

    // return false;
  }

  static bool checkMessageIsInList(List<CommonChatMessage> messages, CommonChatMessage aMsg) {
    bool isInList = false;
    for(CommonChatMessage message in messages) {
      if (aMsg.msgID != null && aMsg.msgID == message.msgID) {
        isInList = true;
        break;
      }
    }
    return isInList;
  }
}
