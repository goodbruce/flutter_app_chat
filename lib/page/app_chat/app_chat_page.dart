import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/navigator_route.dart';
import 'package:flutter_app_chat/provider/provider_widget.dart';
import 'package:flutter_app_chat/provider/view_state_widget.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/view_model/app_chat/app_chat_model.dart';
import 'package:flutter_app_chat/widget/base_widget/appbar_icon_button.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_container/chat_container.dart';
import 'package:provider/provider.dart';

class AppChatPage extends StatefulWidget {
  const AppChatPage({
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
  State<AppChatPage> createState() => _AppChatPageState();
}

class _AppChatPageState extends State<AppChatPage> {

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AppBarIconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {NavigatorRoute.pop()},
        ),
        centerTitle: true,
        backgroundColor: ColorUtil.hexColor(0xffffff),
        foregroundColor: ColorUtil.hexColor(0x777777),
        elevation: 0,
        title: Text(
          "测试聊天页面",
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
      ),
      body: ProviderWidget<AppChatModel>(
        model: AppChatModel(
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
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget(
              onPressed: () {
                // 数据为空时候点击按钮
                print("数据为空时候点击按钮");
                model.initData();
              },
            );
          }

          return Container(
            color: ColorUtil.hexColor(0xf7f7f7),
            child: const ChatContainer(),
          );
        },
      ),
    );
  }

  Map<String, dynamic> getDefaultParams() {
    Map<String, dynamic> params = Map();
    params["groupId"] = 1;
    params["shopId"] = 21835801;
    params["storeId"] = 21835801;

    return params;
  }
}
