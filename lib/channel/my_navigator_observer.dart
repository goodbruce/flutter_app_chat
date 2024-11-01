import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 导航栈监听
class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    print('a-didPop:${route.settings.name}');

    bool? canPop = route.navigator?.canPop();
    bool canNavigatorPop = false;
    if (canPop != null) {
      canNavigatorPop = canPop;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('a-didPush:${route.settings.name}');

    bool? canPop = route.navigator?.canPop();
    bool canNavigatorPop = false;
    if (canPop != null) {
      canNavigatorPop = canPop;
    }
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didReplace({ Route<dynamic>? newRoute, Route<dynamic>? oldRoute }) {
    super.didReplace(newRoute: newRoute,oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
  }
}