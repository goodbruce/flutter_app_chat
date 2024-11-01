/// 定义自定义文本消息内容
/// TEXT(1,"文本"),
/// IMAGE(2,"图片"),
/// VIDEO(3,"视屏"),
/// EMOJI(4,"表情符号"),
/// APP_LINK(5,"应用链接"),
/// FEED(6,"帖子"),
/// COUPON(7,"券"),
/// ITEM(8,"商品"),
/// COUPON_RECEIVE(9,"券领取"),
/// GROUP_NOTICE(10,"群系统通知消息"),

// const String kMsgTypeText = "1"; // 文本
// const String kMsgTypeImage = "2"; // 图片
// const String kMsgTypeVideo = "3"; // 视频
// const String kMsgTypeEmoji = "4"; // 表情符号
// const String kMsgTypeAppLink = "5"; // 应用链接
// const String kMsgTypeFeed = "6"; // 帖子
// const String kMsgTypeCoupon = "7"; // 券
// const String kMsgTypeGoods = "8"; // 商品
// const String kMsgTypeCouponReceive = "9"; // 券领取
// const String kMsgTypeGroupNotice = "10"; // 群系统通知消息

// 自定义消息内容
class CommCustomMsgContent {
  CommCustomMsgContent();
}

// TEXT(1,"文本"),
class CommCustomTextMsgContent {
  int? msgType;
  String? message;

  // 系统发送的
  String? content;
  bool? groupBuying;
  String? sendUserName;
  bool? free;
  bool? systemMsg;
  String? sendUserAvatar;

  CommCustomTextMsgContent();

  CommCustomTextMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    message = json['message'];

    content = json['content'];
    groupBuying = json['groupBuying'];
    sendUserName = json['sendUserName'];
    free = json['free'];
    systemMsg = json['systemMsg'];
    sendUserAvatar = json['sendUserAvatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['message'] = this.message;

    data['content'] = this.content;
    data['groupBuying'] = this.groupBuying;
    data['sendUserName'] = this.sendUserName;
    data['free'] = this.free;
    data['systemMsg'] = this.systemMsg;
    data['sendUserAvatar'] = this.sendUserAvatar;
    return data;
  }
}

// IMAGE(2,"图片"),
class CommCustomImageMsgContent {
  int? msgType;
  String? imageUrl;

  CommCustomImageMsgContent();

  CommCustomImageMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

// VIDEO(3,"视屏"),
class CommCustomVideoMsgContent {
  int? msgType;

  CommCustomVideoMsgContent();

  CommCustomVideoMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    return data;
  }
}

// EMOJI(4,"表情符号"),
class CommCustomEmojiMsgContent {
  int? msgType;

  CommCustomEmojiMsgContent();

  CommCustomEmojiMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    return data;
  }
}

// APP_LINK(5,"应用链接"),
class CommCustomAppLinkMsgContent {
  int? msgType;
  int? appRedirectType;
  String? shareTitle;
  int? fromAppId;
  String? linkUrl;
  String? shareImage;
  String? shareIntro;

  // 系统发送的
  int? groupId;
  bool? groupBuying;
  String? content;
  String? sendUserName;
  bool? free;
  bool? systemMsg;
  String? sendUserAvatar;
  bool? system;

  CommCustomAppLinkMsgContent();

  CommCustomAppLinkMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    appRedirectType = json['appRedirectType'];
    shareTitle = json['shareTitle'];
    fromAppId = json['fromAppId'];
    linkUrl = json['linkUrl'];
    shareImage = json['shareImage'];
    shareIntro = json['shareIntro'];

    groupId = json['groupId'];
    content = json['content'];
    groupBuying = json['groupBuying'];
    sendUserName = json['sendUserName'];
    free = json['free'];
    systemMsg = json['systemMsg'];
    sendUserAvatar = json['sendUserAvatar'];
    system = json['system'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['appRedirectType'] = this.appRedirectType;
    data['shareTitle'] = this.shareTitle;
    data['fromAppId'] = this.fromAppId;
    data['linkUrl'] = this.linkUrl;
    data['shareImage'] = this.shareImage;
    data['shareIntro'] = this.shareIntro;

    data['groupId'] = this.groupId;
    data['content'] = this.content;
    data['groupBuying'] = this.groupBuying;
    data['sendUserName'] = this.sendUserName;
    data['free'] = this.free;
    data['systemMsg'] = this.systemMsg;
    data['sendUserAvatar'] = this.sendUserAvatar;
    data['system'] = this.system;
    return data;
  }
}

// FEED(6,"帖子"),
class CommCustomFeedMsgContent {
  int? msgType;

  List<dynamic>? images;
  int? feedId;
  int? likedCount;
  String? content;
  int? commentCount;
  bool? liked;
  bool? system;

  CommCustomFeedMsgContent();

  CommCustomFeedMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];

    images = json['images'];
    feedId = json['feedId'];
    likedCount = json['likedCount'];
    content = json['content'];
    commentCount = json['commentCount'];
    liked = json['liked'];
    system = json['system'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['images'] = this.images;
    data['feedId'] = this.feedId;
    data['likedCount'] = this.likedCount;
    data['content'] = this.content;
    data['commentCount'] = this.commentCount;
    data['liked'] = this.liked;
    data['system'] = this.system;

    return data;
  }
}

// COUPON(7,"券"),
class CommCustomCouponMsgContent {
  int? msgType;

  String? couponName;
  String? backgroundImg;
  String? shopName;
  int? shareId;
  String? userId;
  bool? system;

  CommCustomCouponMsgContent();

  CommCustomCouponMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];

    couponName = json['couponName'];
    backgroundImg = json['backgroundImg'];
    shopName = json['shopName'];
    shareId = json['shareId'];
    userId = json['userId'];
    system = json['system'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['couponName'] = this.couponName;
    data['backgroundImg'] = this.backgroundImg;
    data['shopName'] = this.shopName;
    data['shareId'] = this.shareId;
    data['userId'] = this.userId;
    data['system'] = this.system;

    return data;
  }
}

// ITEM(8,"商品"),
class CommCustomGoodsMsgContent {
  int? msgType;

  String? image;
  int? itemId;
  int? originalPrice;
  int? price;
  bool? groupBuying;
  int? rewardPoints;
  bool? free;
  String? title;

  // 系统发送的
  int? appRedirectType;
  String? content;
  String? sendUserName;
  bool? systemMsg;
  String? sendUserAvatar;
  bool? system;

  CommCustomGoodsMsgContent();

  CommCustomGoodsMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];

    image = json['image'];
    itemId = json['itemId'];
    originalPrice = json['originalPrice'];
    price = json['price'];
    groupBuying = json['groupBuying'];
    rewardPoints = json['rewardPoints'];
    free = json['free'];
    title = json['title'];

    content = json['content'];
    appRedirectType = json['appRedirectType'];
    sendUserName = json['sendUserName'];
    systemMsg = json['systemMsg'];
    sendUserAvatar = json['sendUserAvatar'];
    system = json['system'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['image'] = this.image;
    data['itemId'] = this.itemId;
    data['originalPrice'] = this.originalPrice;
    data['price'] = this.price;
    data['groupBuying'] = this.groupBuying;
    data['rewardPoints'] = this.rewardPoints;
    data['free'] = this.free;
    data['title'] = this.title;

    data['content'] = this.content;
    data['appRedirectType'] = this.appRedirectType;
    data['sendUserName'] = this.sendUserName;
    data['systemMsg'] = this.systemMsg;
    data['sendUserAvatar'] = this.sendUserAvatar;
    data['system'] = this.system;
    return data;
  }
}

// COUPON_RECEIVE(9,"券领取"),
class CommCustomCouponReceiveMsgContent {
  int? msgType;

  CommCustomCouponReceiveMsgContent();

  CommCustomCouponReceiveMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    return data;
  }
}

// GROUP_NOTICE(10,"群系统通知消息"),
class CommCustomGroupNoticeMsgContent {
  int? msgType;

  CommCustomGroupNoticeMsgContent();

  CommCustomGroupNoticeMsgContent.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    return data;
  }
}
