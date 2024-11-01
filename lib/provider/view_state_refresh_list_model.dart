import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_chat/network/api_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'view_state_list_model.dart';

/// 基于
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  static const int pageSize = 10;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  int getCurPageNum() => _currentPageNum;

  int getFirstPageNum() => pageNumFirst;

  int getPageSize() => pageSize;

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  @override
  void refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      loadData(pageNum: pageNumFirst, completion: (List<T> data, bool isLastPageNo) {
        if (data.isEmpty) {
          refreshController.refreshCompleted(resetFooterState: true);
          list.clear();
          setEmpty();
        } else {
          onCompleted(data);
          list.clear();
          list.addAll(data);
          refreshController.refreshCompleted();
          if (isLastPageNo != null && isLastPageNo == true) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
          setIdle();
        }
      }, failure: (ApiHttpError error) {
        /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
        /// 而是显示之前的页面数据.给出错误提示
        if (init) {
          list.clear();
        }
        refreshController.refreshFailed();
        setError(error);
        showToastMessage(error.message);
      });
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) {
        list.clear();
      }
      refreshController.refreshFailed();

      showToastMessage(s.toString());
      ApiHttpError error = ApiHttpError(ApiHttpErrorType.Default, s.toString());
      setError(error);
    }
  }

  /// 上拉加载更多
  void loadMore() async {
    try {
      loadData(pageNum: ++_currentPageNum, completion: (List<T> data, bool isLastPageNo) {
        if (data.isEmpty) {
          _currentPageNum--;
          refreshController.loadNoData();
        } else {
          onCompleted(data);
          list.addAll(data);
          refreshController.refreshCompleted();
          if (isLastPageNo != null && isLastPageNo == true) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
          notifyListeners();
        }
      }, failure: (ApiHttpError error) {
        _currentPageNum--;
        refreshController.loadFailed();
        showToastMessage(error.message);
      });
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      showToastMessage(e.toString());
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
    }
  }

  // 加载数据
  @override
  void loadData(
      {int? pageNum,
      required Function(List<T>, bool isLastPageNo) completion,
      required Function(ApiHttpError) failure});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
