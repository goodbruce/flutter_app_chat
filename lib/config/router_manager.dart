import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_chat/config/my_cupertino_page_route.dart';
import 'package:flutter_app_chat/page/app_chat/app_chat_page.dart';
import 'package:flutter_app_chat/page/app_chat/app_conversation_page.dart';
import 'package:flutter_app_chat/page/other/download_page.dart';
import 'package:flutter_app_chat/page_route/page_route_animation.dart';

class RouterName {
  // 聊天界面Chat
  static const String chat = 'chat';

  // 会话conversation
  static const String conversation = 'conversation';

  // 上传页面（示例）
  static const String downloadPage = 'downloadPage';
}

class RouterManager {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("generateRoute: ${settings}, name:${settings.name}");
    switch (settings.name) {
      case RouterName.conversation:
        {
          return NoAnimRouteBuilder(const AppConversationPage(
            title: "AppConversationPage",
          ));
        }
        break;

      case RouterName.chat:
        {
          return MyCupertinoPageRoute(
            builder: (_) => AppChatPage(
              arguments: settings.arguments,
              title: 'ChatPage',
            ),
          );
        }
        break;

      case RouterName.downloadPage:
        {
          return MyCupertinoPageRoute(
            builder: (_) => DownloadPage(
              arguments: settings.arguments,
            ),
          );
        }
        break;

      default:
        return NoAnimRouteBuilder(Container());
    }
  }
}
