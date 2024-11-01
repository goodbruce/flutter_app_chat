import 'package:event_bus/event_bus.dart';

final kCommEventBus = EventBus();

// 传递的类型操作
enum CommEventBusType {
  commEventBusTypeSendText, // 发送文本消息
  commEventBusTypeMoreOption, // 打开Option
  commEventBusTypePublishPost, // 发帖
  commEventBusTypeReceiveMsg, // 收到消息
}

// 传递的数据
class CommEventBusModel {
  // 自动
  CommEventBusType? commEventBusType;
  // 数据
  dynamic data;
  // 初始化
  CommEventBusModel({this.commEventBusType, this.data});

  @override
  String toString() {
    // TODO: implement toString
    return "commEventBusType:${commEventBusType},data:${data}";
  }
}
