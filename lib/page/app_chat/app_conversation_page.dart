import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/navigator_route.dart';
import 'package:flutter_app_chat/config/router_manager.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:flutter_app_chat/provider/provider_widget.dart';
import 'package:flutter_app_chat/provider/view_state_widget.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/view_model/app_chat/app_conversation_model.dart';
import 'package:flutter_app_chat/widget/common_widget/show_loading_hud.dart';
import 'package:flutter_app_chat/widget/conversation_widget/conversation_item.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 会话列表
class AppConversationPage extends StatefulWidget {
  const AppConversationPage({
    Key? key,
    this.messages,
    this.uniqueId,
    this.arguments,
    required this.title,
  }) : super(key: key);

  final Object? arguments;
  final String? messages;
  final String? uniqueId;

  final String title;

  @override
  State<AppConversationPage> createState() => _AppConversationPageState();
}

class _AppConversationPageState extends State<AppConversationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context, listen: false);
    String? imUserId = userModel.session.imUserId;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorUtil.hexColor(0xffffff),
        foregroundColor: ColorUtil.hexColor(0x777777),
        elevation: 0,
        title: Text(
          "聊天Chat",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontSize: 17,
            color: ColorUtil.hexColor(0x333333),
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
        ),
        shadowColor: ColorUtil.hexColor(0xffffff),
        toolbarHeight: 44.0,
        bottomOpacity: 0.0,
        actions: [
        ],
      ),
      body: ProviderWidget<AppConversationModel>(
        model: AppConversationModel(
          txImUserId: imUserId,
          groupId: 1,
          storeId: 21835801,
          shopId: 21835801,
        ),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return const ViewStateBusyWidget();
          } else if (model.isError) {
            return ViewStateErrorWidget(
              onPressed: () {
                // 显示重试按钮
                print("Error时候点击按钮");
                model.initData();
              },
              error: model.viewStateError,
            );
          }

          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
              addRepaintBoundaries: false,
              addAutomaticKeepAlives: false,
              itemCount: 1,
              // 强制高度
              itemBuilder: (BuildContext context, int index) {
                return ConversationWidget(
                  title: "聊天测试页面",
                  content: "",
                  onPressed: () {
                    enterChatPage(
                      context: context,
                      model: model,
                    );
                  },
                  showArrow: true,
                );
              },
          );
        },
      ),
    );
  }

  // 退出APP
  void logoutPressed() {
    UserModel userModel =
        Provider.of<UserModel>(OneContext().context!, listen: false);
  }

  // 进入聊天界面
  void enterChatPage({
    required BuildContext context,
    required AppConversationModel model,
  }) {
    NavigatorRoute.push(RouterName.chat, arguments: {"name":"测试聊天页面"});
  }
}
