import 'package:flutter_app_chat/network/api_config.dart';

import 'view_state_model.dart';

/// 基于
abstract class ViewStateListModel<T> extends ViewStateModel {
  /// 页面数据
  List<T> list = [];

  ViewStateListModel() : super(viewState: ViewState.busy);

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy();
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      // 判断是否是最后一页
      loadData(completion: (List<T> data, bool isLastPageNo) {
        if (data.isEmpty) {
          list.clear();
          setEmpty();
        } else {
          onCompleted(data);
          list.clear();
          list.addAll(data);
          setIdle();
        }
      }, failure: (ApiHttpError error) {
        if (init) list.clear();
        setError(error);
      });
    } catch (s) {
      if (init) list.clear();

      ApiHttpError error = ApiHttpError(ApiHttpErrorType.Default, s.toString());
      setError(error);
    }
  }

  // 加载数据
  void loadData(
      {int? pageNum,
      required Function(List<T>, bool isLastPageNo) completion,
      required Function(ApiHttpError) failure});

  onCompleted(List<T> data) {}
}
