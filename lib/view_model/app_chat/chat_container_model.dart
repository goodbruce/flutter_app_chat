import 'package:flutter_app_chat/global/user.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:flutter_app_chat/network/api_config.dart';
import 'package:flutter_app_chat/provider/view_state_model.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_announcement_notice.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_navigator_entry.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_vistor_statistics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 聊天界面的内容相关的操作
class ChatContainerModel extends ViewStateModel {
  int? groupId;
  int? shopId;
  int? storeId;

  UserModel userModel;

  // 数据统计
  CommVisitorStatistics visitorStatistics = CommVisitorStatistics();

  // 公告信息
  CommAnnouncementNotice announcementNotice = CommAnnouncementNotice();

  // 导航入口
  List<CommNavigatorEntry> navigatorEntries = [];

  // 更多more导航入口
  List<CommMoreOption> moreOptionEntries = [];

  ChatContainerModel(
      {this.groupId,
      this.shopId,
      this.storeId,
      required this.userModel}) {
  }

  initData() async {
    setIdle();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
