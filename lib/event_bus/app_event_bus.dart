
typedef AppEventCallback = void Function(dynamic arg);

// 事件总线
// 订阅者回调签名
class AppEventBus {
  //私有构造函数
  AppEventBus._internal();

  //保存单例
  static AppEventBus _singleton = AppEventBus._internal();

  //工厂构造函数
  factory AppEventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  //Map<eventName, Map<hashCode, List[]>>
  final _emap = Map<Object, Map<String, List<AppEventCallback>?>>();

  // final _emap = Map<Object, List<GamePrizeEventCallback>?>();

  //添加订阅者
  void on(eventName, Object object, AppEventCallback f) {
    String hashCode = object.hashCode.toString();
    Map<String, List<AppEventCallback>?>? map = _emap[eventName];
    if (map == null) {
      map = Map<String, List<AppEventCallback>?>();
      _emap[eventName] = map;
    }

    map[hashCode] ??= <AppEventCallback>[];
    map[hashCode]!.add(f);
  }

  //移除订阅者
  void off(eventName, Object object, [AppEventCallback? f]) {
    String hashCode = object.hashCode.toString();
    Map<String, List<AppEventCallback>?>? map = _emap[eventName];
    if (map != null) {
      var list = map[hashCode];
      if (list == null) return;
      if (f == null) {
        map[hashCode] = null;
      } else {
        list.remove(f);
      }
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    Map<String, List<AppEventCallback>?>? map = _emap[eventName];
    if (map != null) {
      for (String hashCode in map.keys) {
        List<AppEventCallback>? list = map[hashCode];
        if (list != null && list.isNotEmpty) {
          int len = list.length - 1;
          //反向遍历，防止订阅者在回调中移除自身带来的下标错位
          for (var i = len; i > -1; --i) {
            list[i](arg);
          }
        }
      }
    }
  }
}
