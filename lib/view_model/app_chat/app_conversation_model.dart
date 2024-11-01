import 'package:flutter_app_chat/provider/view_state_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 获取用户的群组列表
class AppConversationModel extends ViewStateModel {
  int? groupId;
  int? shopId;
  int? storeId;
  String? txImUserId;

  AppConversationModel(
      {this.groupId, this.shopId, this.storeId, this.txImUserId});

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  initData() async {
    setIdle();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
