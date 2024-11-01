import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/global/user_model.dart';
import 'package:flutter_app_chat/network/message_constant.dart';
import 'package:flutter_app_chat/provider/provider_widget.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/view_model/app_chat/chat_container_model.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_container/chat_loading_indicator.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_entry_container/chat_navigator_bar.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_entry_container/chat_nonouncement_bar.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_entry_container/chat_statistics_bar.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_convertor.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_message_panel/chat_cell_elem.dart';
import 'package:flutter_app_chat/widget/chat_widget/chat_more_option_helper.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_announcement_notice.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_custom_msgcontent.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_event_bus.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_message.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_navigator_entry.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';
import 'package:flutter_app_chat/widget/chat_widget/message_elem_helper.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

class ChatContainer extends StatefulWidget {
  const ChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  // 聊天列表的Key
  final GlobalKey chatContainerKey = GlobalKey();

  // 当前ContainerKey
  final GlobalKey chatListViewKey = GlobalKey();

  // 消息列表
  List<CommonChatMessage> messageList = [];

  // 这次加载的历史消息
  List<CommonChatMessage>? historyMessageList;

  // Controller
  ChatInputBarController chatInputBarController = ChatInputBarController();

  // 滚动控制Controller
  ScrollController scrollController = ScrollController();

  // 表情键盘类型
  ChatInputBarShowType inputBarShowType = ChatInputBarShowType.inputBarShowIdle;

  // 是否加载中
  bool isLoading = false;

  // 是否需要隐藏表情键盘手势
  bool isNeedDismissPanelGesture = false;

  // Stream订阅
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createMessageList();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.position.maxScrollExtent == 0) {
        // not scroll content, call load more
        if (isLoading == false) {
          loadHistoryMore();
        }
      }
    });

    addScrollListener();

    addChatInputController();

    eventStreamSubscription();
  }

  // 启动eventbus
  void eventStreamSubscription() {
    UserModel userModel =
        Provider.of<UserModel>(OneContext().context!, listen: false); // 来自不同的类型

    streamSubscription =
        kCommEventBus.on<CommEventBusModel>().listen((commEventBusModel) {
      print(
          "eventStreamSubscription commEventBusModel:${commEventBusModel.toString()}");

      if (CommEventBusType.commEventBusTypeSendText ==
          commEventBusModel.commEventBusType) {
        // 发送文本消息
        String text = commEventBusModel.data;
        // 文本需要通过SDK进行发送
        CommCustomTextMsgContent textMsgContent = CommCustomTextMsgContent();
        textMsgContent.msgType = int.parse(kMsgTypeText);
        textMsgContent.message = text;

        String messageText = jsonEncode(textMsgContent.toJson());

        // 发送成功
        CommonChatMessage textMessage =
            ChatMessageConvertor.createTextMessage(messageText, userModel);
        textMessage.messageStatus = CommMessageStatus.commMessageStatusSending;
        if (!ChatMessageConvertor.checkMessageIsInList(
            messageList, textMessage)) {
          messageList.insert(0, textMessage);
        }
        setState(() {});
        // ChatIMManager()
        //     .sendGroupTextMessage(widget.userGroupDo.txImGroupId ?? "", text,
        //         callback: (bool success, String? errorMessage) {
        //   if (success) {
        //     textMessage.messageStatus =
        //         CommMessageStatus.commMessageStatusSuccess;
        //     setState(() {});
        //   } else {
        //     textMessage.messageStatus =
        //         CommMessageStatus.commMessageStatusFailed;
        //     setState(() {});
        //     FlutterLoadingHud.showToast(message: errorMessage);
        //   }
        // });
      } else if (CommEventBusType.commEventBusTypeMoreOption ==
          commEventBusModel.commEventBusType) {
        // 更多操作
        CommMoreOption commMoreOption = commEventBusModel.data;
        ChatMoreOptionHelper.moreOptionTap(
            userModel.getImUserId() ?? "", commMoreOption, getDefaultParams());
      } else if (CommEventBusType.commEventBusTypePublishPost ==
          commEventBusModel.commEventBusType) {
        // 发帖
        Map<String, dynamic> arguments = getDefaultParams();
        arguments['imUserId'] = userModel.getImUserId();
        // NavigatorRoute.push(RouterName.postPublishPage, arguments: arguments);
      } else if (CommEventBusType.commEventBusTypeReceiveMsg ==
          commEventBusModel.commEventBusType) {
        // 收到消息
      }
    });
  }

  // 滚动控制器Controller
  void addScrollListener() {
    scrollController.addListener(() {
      print("addScrollListener pixels:${scrollController.position.pixels},"
              "maxScrollExtent:${scrollController.position.maxScrollExtent}"
              "isLoading:${isLoading}");
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (isLoading == false) {
          loadHistoryMore();
        }
      }
    });
  }

  // 聊天的Controller的控制
  void addChatInputController() {
    // 滚动到底部控制
    chatInputBarController.scrollToBottom = () {
      scrollToBottom();
    };

    // 是否需要隐藏表情键盘手势
    chatInputBarController.chatContainerNeedDismissPanelGesture =
        (bool isNeedDismissPanelGesture) {
      print(
          "chatContainerNeedDismissPanelGesture isNeedDismissPanelGesture:${isNeedDismissPanelGesture}");
      this.isNeedDismissPanelGesture = isNeedDismissPanelGesture;
      setState(() {});
    };
  }

  // 滚动到底部
  void scrollToBottom() {
    scrollController.jumpTo(0.0);
  }

  // 滚动到底部动画
  Future<void> scrollToBottomAnimation() async {
    scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  // 当键盘或者表情键盘弹出的时候，则直接将其隐藏
  void handlerGestureTapDown(DragDownDetails details) {
    // 隐藏键盘键盘或者表情键盘弹出
    if (chatInputBarController.dismissChatInputPanel != null) {
      chatInputBarController.dismissChatInputPanel!();
    }
  }

  // 加载更多历史消息
  void loadHistoryMore() async {
    if (isLoading == true) {
      return;
    }

    isLoading = true;
    // 模拟请求接口
    Future.delayed(Duration(milliseconds: 5000), () {
      createMessageList();

      setState(() {});
      isLoading = false;
    });
  }

  // 模拟初始化数据
  void createMessageList() async {
    String groupID = "";
    int count = 10;
    String? lastMsgID;

    if (messageList.isNotEmpty) {
      CommonChatMessage lastChatMessage = messageList.last;
      lastMsgID = lastChatMessage.msgID;
    }

    List<CommonChatMessage> tmpMessageList =
        await ChatMessageConvertor.getGroupHistoryMessageList(
            groupID: groupID, count: count, lastMsgID: lastMsgID);

    historyMessageList = tmpMessageList;
    if (tmpMessageList != null && tmpMessageList.isNotEmpty) {
      messageList.addAll(tmpMessageList);
    }
    setState(() {});
  }

  // 点击重发消息
  void onSendFailedIndicatorPressed(
      BuildContext context, CommonChatMessage chatMessage) {
    print("onSendFailedIndicatorPressed chatMessage:${chatMessage}");
  }

  // 气泡单击事件
  void onBubbleTapPressed(BuildContext context, CommonChatMessage chatMessage) {
    print("onBubbleTapPressed chatMessage:${chatMessage}");
    MessageElemHelper.elemBubbleTap(context, chatMessage,
        additionalArguments: getDefaultParams());
  }

  // 气泡长按事件
  void onBubbleLongPressed(BuildContext context, CommonChatMessage chatMessage,
      LongPressStartDetails details, ChatBubbleFrame? chatBubbleFrame) {
    print("onBubbleLongPressed chatMessage:${chatMessage}");
    MessageElemHelper.elemBubbleLongPress(context, chatMessage,
        additionalArguments: getDefaultParams(),
        details: details,
        chatBubbleFrame: chatBubbleFrame);
  }

  // 气泡双击事件
  void onBubbleDoubleTapPressed(
      BuildContext context, CommonChatMessage chatMessage) {
    print("onBubbleDoubleTapPressed chatMessage:${chatMessage}");
    MessageElemHelper.elemBubbleDoubleTap(context, chatMessage,
        additionalArguments: getDefaultParams());
  }

  // 判断是否显示管理admin
  bool checkShowPostAndStatistics(ChatContainerModel model) {
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        Provider.of<UserModel>(context, listen: false); // 来自不同的类型

    return ProviderWidget<ChatContainerModel>(
      model: ChatContainerModel(
        groupId: 1,
        storeId: 21835801,
        shopId: 21835801,
        userModel: userModel,
      ),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        return Container(
          key: chatContainerKey,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildChatStatisticsBar(model),
              ChatAnnouncementBar(
                announcementNotice: model.announcementNotice,
                onAnnouncementPressed: () {
                  onAnnouncementPressed(model.announcementNotice);
                },
              ),
              buildListContainer(model, context),
              ChatNavigatorBar(
                onNavigatorItemPressed: (CommNavigatorEntry navigatorEntry) {
                  onNavigatorItemPressed(navigatorEntry, model);
                },
                navigatorEntries: model.navigatorEntries,
              ),
              ChatInputBar(
                chatInputBarController: chatInputBarController,
                moreOptionEntries: model.moreOptionEntries,
                showPostEnterButton: checkShowPostAndStatistics(model),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildChatStatisticsBar(ChatContainerModel model) {
    bool showPostAndStatistics = checkShowPostAndStatistics(model);
    if (showPostAndStatistics == true) {
      return ChatStatisticsBar(
        visitorStatistics: model.visitorStatistics,
        onStatisticsBarPressed: () {
          onStatisticsBarPressed();
        },
      );
    }

    return Container();
  }

  Widget buildListContainer(ChatContainerModel model, BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtil.hexColor(0xf7f7f7),
        ),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topCenter,
        child: isNeedDismissPanelGesture
            ? GestureDetector(
                onPanDown: handlerGestureTapDown,
                child: buildCustomScrollView(model, context),
              )
            : buildCustomScrollView(model, context),
      ),
    );
  }

  // 嵌套的customScrollView
  Widget buildCustomScrollView(ChatContainerModel model, BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext lbContext, BoxConstraints constraints) {
      double layoutHeight = constraints.biggest.height;
      return CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(0.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.topCenter,
                height: layoutHeight,
                child: buildScrollConfiguration(model, context),
              ),
            ),
          ),
        ],
      );
    });
  }

  // 嵌套的聊天列表
  Widget buildChatSliverList(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == messageList.length) {
            if (historyMessageList != null && historyMessageList!.isEmpty) {
              return const ChatNoMoreIndicator();
            }
            return const ChatLoadingIndicator();
          } else {
            CommonChatMessage chatMessage = messageList[index];
            return ChatCellElem(
              childElem: MessageElemHelper.layoutCellElem(chatMessage),
              chatMessage: chatMessage,
              onSendFailedIndicatorPressed: (CommonChatMessage chatMessage) {
                onSendFailedIndicatorPressed(context, chatMessage);
              },
              onBubbleTapPressed: (CommonChatMessage chatMessage) {
                onBubbleTapPressed(context, chatMessage);
              },
              onBubbleDoubleTapPressed: (CommonChatMessage chatMessage) {
                onBubbleDoubleTapPressed(context, chatMessage);
              },
              onBubbleLongPressed: (CommonChatMessage chatMessage,
                  LongPressStartDetails details,
                  ChatBubbleFrame? chatBubbleFrame) {
                onBubbleLongPressed(
                    context, chatMessage, details, chatBubbleFrame);
              },
            );
          }
        },
        childCount: messageList.length + 1,
      ),
    );
  }

  // 聊天列表
  Widget buildScrollConfiguration(
      ChatContainerModel model, BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      key: chatListViewKey,
      shrinkWrap: true,
      addRepaintBoundaries: true,
      controller: scrollController,
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
      itemCount: messageList.length + 1,
      reverse: true,
      clipBehavior: Clip.none,
      itemBuilder: (BuildContext context, int index) {
        if (index == messageList.length) {
          if (historyMessageList != null && historyMessageList!.isEmpty) {
            return const ChatNoMoreIndicator();
          } else {
            return const ChatLoadingIndicator();
          }
        }

        CommonChatMessage chatMessage = messageList[index];
        return ChatCellElem(
          childElem: MessageElemHelper.layoutCellElem(chatMessage),
          chatMessage: chatMessage,
          onSendFailedIndicatorPressed: (CommonChatMessage chatMessage) {
            onSendFailedIndicatorPressed(context, chatMessage);
          },
          onBubbleTapPressed: (CommonChatMessage chatMessage) {
            onBubbleTapPressed(context, chatMessage);
          },
          onBubbleDoubleTapPressed: (CommonChatMessage chatMessage) {
            onBubbleDoubleTapPressed(context, chatMessage);
          },
          onBubbleLongPressed: (CommonChatMessage chatMessage,
              LongPressStartDetails details, ChatBubbleFrame? chatBubbleFrame) {
            onBubbleLongPressed(context, chatMessage, details, chatBubbleFrame);
          },
        );
      },
    );
  }

  // 导航事件
  void onNavigatorItemPressed(
      CommNavigatorEntry navigatorEntry, ChatContainerModel model) {
    // 跳转到具体的页面
    print("onNavigatorItemPressed:${navigatorEntry.toJson()}");
    String pathString = navigatorEntry.path ?? "";
    // if (pathString.contains("packageGood")) {
    //   NavigatorRoute.push(RouterName.goodsListPage,
    //       arguments: getDefaultParams());
    //   return;
    // }
    //
    // if (pathString.contains("packagePersonal")) {
    //   Map<String, dynamic> params = getDefaultParams();
    //   params['role'] = model.memberRole;
    //   NavigatorRoute.push(RouterName.userCenter, arguments: params);
    //   return;
    // }
  }

  // 点击查看公告详情
  void onAnnouncementPressed(CommAnnouncementNotice announcementNotice) {
    // 点击查看公告详情
    // NavigatorRoute.push(RouterName.groupNoticeDetailPage,
    //     arguments: getDefaultParams());
  }

  // 点击跳转到数据统计页面
  void onStatisticsBarPressed() {
    // 点击跳转到数据统计页面
    // NavigatorRoute.push(RouterName.visitorStatisticsPage,
    //     arguments: getDefaultParams());
  }

  Map<String, dynamic> getDefaultParams() {
    Map<String, dynamic> params = Map();
    params["groupId"] = 1;
    params["shopId"] = 21835801;
    params["storeId"] = 21835801;

    return params;
  }
}
