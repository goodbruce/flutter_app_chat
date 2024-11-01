import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';

// 处理点击 + 更多的相关操作
class ChatMoreOptionHelper {
  static void moreOptionTap(
    String imUserId,
    CommMoreOption commMoreOption,
    Map<String, dynamic> extParams,
  ) {
    if (kOptionCamera == commMoreOption.linkUrl) {
      // 相机
      return;
    }

    if (kOptionAlbum == commMoreOption.linkUrl) {
      // 相册
      return;
    }
  }
}
