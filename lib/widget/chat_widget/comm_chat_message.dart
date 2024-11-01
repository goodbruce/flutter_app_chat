
import 'package:flutter/material.dart';

const String kLastMessageTimeKey = "kLastMessageTimeKey";

// 会话类型
enum CommConversationType {
  commConversationTypeDefault,      //默认
  commConversationTypeP2P,          //单聊
  commConversationTypeGroup,        //群聊
}

// 消息的类型
enum CommMessageFromType {
  commMessageFromTypeDefault,       //初始化状态
  commMessageFromTypeSystem,        //系统
  commMessageFromTypeOutgoing,      //发送出去
  commMessageFromTypeReceiving,     //接收
}

// 自定义消息来源类型
enum CommMessageType {
  commMessageTypeNone,              //默认
  commMessageTypeTime,              //该行为时间
  commMessageTypeTips,              //系统提示消息
  commMessageTypeCustom,            //自定义消息
  commMessageTypeText,              //文本消息
  commMessageTypeImage,             //图片消息
  commMessageTypeAudio,             //语音消息
  commMessageTypeVideo,             //视频消息
  commMessageTypeLocation,          //定位消息
  commMessageTypeRedPacket,        //红包消息
  commMessageTypeFile,             //文件消息
  commMessageTypeGoods,             //商品消息
  commMessageTypeGameWeb,           //游戏链接消息
  commMessageTypeCoupon,            //分享的券消息
  commMessageTypePoster,            //分享的帖子消息
  commMessageTypeBuyTogether,       //拼团商品消息
}

// 自定义消息状态
enum CommMessageStatus {
  commMessageStatusDefault,  ///< 初始化状态
  commMessageStatusSending,  ///< 消息发送中
  commMessageStatusSuccess,  ///< 消息发送成功
  commMessageStatusFailed,  ///< 消息发送失败
  commMessageStatusDeleted,  ///< 消息被删除
  commMessageStatusLocalImported,  ///< 导入到本地的消息
  commMessageStatusLocalRevoked,  ///< 被撤销的消息
}

// 聊天的数据
class CommonChatMessage {
  // 原消息数据
  dynamic imMessage;

  // 自定义的消息体内容
  dynamic msgContentModel;

  // 会话类型
  CommConversationType conversationType = CommConversationType.commConversationTypeDefault;

  // 消息类型
  CommMessageType messageType = CommMessageType.commMessageTypeNone;

  // 消息状态
  CommMessageStatus messageStatus = CommMessageStatus.commMessageStatusDefault;

  // 消息来源类型
  CommMessageFromType messageFromType = CommMessageFromType.commMessageFromTypeDefault;

  // 消息时间, 毫秒数
  String? formatterSeconds;

  // 是否显示时间
  bool displayTime = false;

  // msgID
  String? msgID;

  // 消息时间
  String? timeString;

  // 用户id
  String? userId;

  // 用户名
  String? userName;

  // 头像
  String? userAvatar;

  // Tips文本内容
  String? tipsContentText;

  // 文本内容
  String? text;

  // 图片地址
  String? originImageUrl;
  String? imageUrl;
  bool isGif = false;       //是否是gif图
  bool isSticker = false;   //是否是表情贴图
  Size? imageSize;

  // 语音音频文件
  String? duration;
  String? audioUrl; //音频文件地址
  bool hasPlayed = false; //音频是否播放过
  bool isPlaying = false; //音频是否正在播放

  // 定位地理位置
  String? locationInfo;
  double? longitude; //经度
  double? latitude;  //纬度

  // 视频文件
  String? videoUrl;   //视频文件地址
  String? videoThumbImageUrl;
  Size? videoThumbImageSize;

  // 红包消息
  String? redPacketTitle;   // 标题
  String? redPacketImageUrl;
  String? redPacketStatus;

  // 商品信息
  String? goodsTitle;   // 标题
  String? goodsImageUrl;
  String? showGoodsPrice;
  String? showGoodsOriginPrice; // 原价

  // 游戏链接web信息
  String? gWebTitle;   // 标题
  String? gWebContent;   // 内容
  String? gWebUrl;
  String? gShareImageUrl;

  // 分享的券信息
  String? couponTitle;   // 标题
  String? couponContent;   // 内容
  String? couponUrl;
  String? couponShareImageUrl;

  // 分享的帖子信息
  String? postFeedId;   // 内容
  String? postContent;   // 内容
  List <CommonChatMessagePosterImage>? postImages;   // 帖子图片
  String? showLikeNum;    // 点赞数
  String? showCommentNum; // 评论数
  bool liked = false; // 是否点赞
  bool isDetailLoaded = false; // 是否已经获取到详情

  // 拼团信息
  String? ptGoodsTitle;   // 标题
  String? ptGoodsImageUrl;
  String? ptGoodsCurrentPrice; // 现价
  String? ptGoodsOriginPrice; // 原价
}

// 帖子图片
class CommonChatMessagePosterImage {
  String? imageUrl;
  Size? imageSize;
}

