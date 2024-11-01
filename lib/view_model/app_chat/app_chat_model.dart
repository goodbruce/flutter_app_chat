import 'package:flutter_app_chat/provider/view_state_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 获取聊天界面
class AppChatModel extends ViewStateModel {
  int? groupId;
  int? shopId;
  int? storeId;

  AppChatModel({this.groupId, this.shopId, this.storeId});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  initData() async {
    setIdle();
    refreshData();
  }

  void refreshData() {}

  /**
   * User user = User(
      userId: "7a8e1b9f0",
      nickName: "KailasaBing",
      avatar:
      "https://c-ssl.dtstatic.com/uploads/blog/202203/19/20220319205139_b509f.thumb.1000_0.jpg",
      );

      userModel.user = user;
   */

  @override
  void dispose() {
    // TODO: implement dispose
    refreshController.dispose();
    super.dispose();
  }
}
