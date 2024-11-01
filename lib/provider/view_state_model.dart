import 'package:flutter/material.dart';
import 'package:flutter_app_chat/generated/l10n.dart';
import 'package:flutter_app_chat/network/api_config.dart';
import 'package:flutter_app_chat/widget/common_widget/show_loading_hud.dart';

import 'view_state.dart';

export 'view_state.dart';

class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState = ViewState.idle;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    viewStateError = ViewStateError(ViewStateErrorType.defaultError);
    _viewState = viewState;

    // 如果未被释放，并且有监听者时候，可以调用通知监听者notifyListeners
    if (!_disposed && hasListeners) {
      notifyListeners();
    }
  }

  /// ViewStateError
  ViewStateError viewStateError =
      ViewStateError(ViewStateErrorType.defaultError);

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  ///
  /// get
  bool get isBusy => viewState == ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  bool get isDisposed => _disposed;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(ApiHttpError error, {String message = ""}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    if (ApiHttpErrorType.NetWork == error.errorType) {
      errorType = ViewStateErrorType.networkTimeOutError;
    }
    print("setError errorType：${errorType}");

    viewState = ViewState.error;
    viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: error.message,
    );
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  void showErrorMessage(context, {String message = ""}) {
    if (viewStateError != null || message != null) {
      if (viewStateError.isNetworkTimeOut) {
        message = S.of(context).viewStateMessageNetworkError;
      } else {
        message = viewStateError.message;
      }
      Future.microtask(() {
        showFlutterToast(message);
      });
    }
  }

  /// 显示Toast消息
  void showToastMessage(String? message) {
    if (message != null) {
      Future.microtask(() {
        showFlutterToast(message);
      });
    }
  }

  // 显示加载hud
  void showLoadingHud({String? message}) {
    FlutterLoadingHud.showLoading(message: message);
  }

  // 隐藏加载hud
  void dismissLoadingHud() {
    FlutterLoadingHud.dismiss();
  }

  void showFlutterToast(String? message) {
    FlutterLoadingHud.showToast(message: message);
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $viewStateError}';
  }

  @override
  void notifyListeners() {
    print('view_state_model notifyListeners -->$_disposed');
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    print('view_state_model dispose -->$runtimeType');
    print('view_state_model dispose -->${_disposed}');
    super.dispose();
  }
}
