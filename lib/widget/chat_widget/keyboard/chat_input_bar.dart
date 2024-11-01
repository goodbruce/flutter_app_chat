import 'package:flutter/material.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_emoji.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_event_bus.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bottom_panel.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_emoji_preview.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_text_field_bar.dart';

// 键盘bar
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    Key? key,
    required this.chatInputBarController,
    required this.moreOptionEntries,
    required this.showPostEnterButton,
  }) : super(key: key);

  final ChatInputBarController chatInputBarController;
  final List<CommMoreOption> moreOptionEntries;
  final bool showPostEnterButton;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  // Globalkey
  final GlobalKey inputBarBottomAreaKey = GlobalKey();

  // 输入框的key
  final GlobalKey chatInputTextFieldBarKey = GlobalKey();

  // 默认
  ChatInputBarShowType inputBarShowType = ChatInputBarShowType.inputBarShowIdle;
  ChatInputBarShowType preInputBarShowType =
      ChatInputBarShowType.inputBarShowIdle;

  // 输入框编辑
  TextEditingController textEditingController = TextEditingController();

  // 是否显示了emoji预览
  bool isShowedEmojiPreview = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addChatInputController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 聊天的Controller的控制
  void addChatInputController() {
    // 隐藏键盘键盘或者表情键盘
    widget.chatInputBarController.dismissChatInputPanel = () {
      dismissChatInputPanel();
    };
  }

  // 隐藏表情键盘控制
  void dismissChatInputPanel() {
    changedInputBarShowType(
      shouldFocus: false,
      toShowType: ChatInputBarShowType.inputBarShowIdle,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  // 键盘、emoji、more切换
  void onEmojiButtonPressed() {
    changedInputBarShowType(
      shouldFocus: false,
      toShowType: ChatInputBarShowType.inputBarShowEmoji,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  void onOutEmojiButtonPressed() {
    changedInputBarShowType(
      shouldFocus: true,
      toShowType: ChatInputBarShowType.inputBarShowKeyboard,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  void onMoreButtonPressed() {
    changedInputBarShowType(
      shouldFocus: false,
      toShowType: ChatInputBarShowType.inputBarShowMore,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  void onOutMoreButtonPressed() {
    changedInputBarShowType(
      shouldFocus: false,
      toShowType: ChatInputBarShowType.inputBarShowIdle,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  void onInputFieldPressed() {
    changedInputBarShowType(
      shouldFocus: true,
      toShowType: ChatInputBarShowType.inputBarShowKeyboard,
    );

    // 滚动到底部
    listScrollToBottom();

    // 表情及更多按钮状态
    updateBarIconStatus();
  }

  // 输入完成
  void onInputOnEditingCompleted() {
    // 输入完成
  }

  // 点击键盘发送提交
  void inputOnSubmitted(String text) {
    // 点击键盘发送提交
    onTextFieldSend();
  }

  void onPostButtonPressed() {
    dismissChatInputPanel();

    // 发送eventBus事件
    CommEventBusModel eventBusModel = CommEventBusModel(
      commEventBusType: CommEventBusType.commEventBusTypePublishPost,
      data: null,
    );
    kCommEventBus.fire(eventBusModel);
  }

  // 更新状态
  void changedInputBarShowType({
    required bool shouldFocus,
    required ChatInputBarShowType toShowType,
  }) {
    preInputBarShowType = inputBarShowType;

    if (widget.chatInputBarController.inputFocusChanged != null) {
      widget.chatInputBarController.inputFocusChanged!(shouldFocus);
    }
    inputBarShowType = toShowType;

    if (widget.chatInputBarController.updateInputBarType != null) {
      widget.chatInputBarController.updateInputBarType!(
          preInputBarShowType, inputBarShowType);
    }

    if (widget.chatInputBarController.startBottomPanelAnimation != null) {
      widget.chatInputBarController.startBottomPanelAnimation!();
    }
  }

  // 通知聊天列表滚动到底部
  void listScrollToBottom() {
    if (widget.chatInputBarController.scrollToBottom != null) {
      widget.chatInputBarController.scrollToBottom!();
    }
  }

  // 表情及更多按钮状态
  void updateBarIconStatus() {
    if (widget.chatInputBarController.textFieldBarStatus != null) {
      widget.chatInputBarController.textFieldBarStatus!(inputBarShowType);
    }
  }

  // 手指取消后，移除表情预览dialog
  void onEmojiLongCancel(BuildContext context) {
    if (isShowedEmojiPreview) {
      // Navigator.of(_chatInputBarKey.currentContext!).pop();
    }
    isShowedEmojiPreview = false;
  }

  // 表情长按预览表情
  void onEmojiLongPressed(
    BuildContext context, {
    required CommonChatEmojiItem emojiItem,
    Offset? globalPosition,
  }) {
    print("globalPosition：${globalPosition}, "
        "isShowedEmojiPreview：${isShowedEmojiPreview},");

    if (globalPosition != null) {
      double previewWidth = 140;
      double previewHeight = 180;

      double emojiSize = 36;

      isShowedEmojiPreview = true;

      // 长按表情预览
      showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierColor: Colors.black.withOpacity(0.0),
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Stack(
            children: [
              Positioned(
                top: globalPosition.dy - previewHeight + emojiSize,
                left: globalPosition.dx - previewWidth + previewWidth / 2.0,
                child: ChatInputEmojiPreview(
                  emojiItem: emojiItem,
                  height: previewHeight,
                  width: previewWidth,
                ),
              ),
            ],
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: child,
          );
        },
      );
    }
  }

  // 点击表情
  void onEmojiTapPressed(CommonChatEmojiItem emojiItem) {
    print("onEmojiTapPressed emojiItem:${emojiItem.emojiName}");
    int index = textEditingController.selection.baseOffset;
    if (index < 0) {
      index = 0;
    }
    print("onEmojiTapPressed cursorIndex:${index}");

    // 光标左边字符串
    String leftText = textEditingController.text.substring(0, index);
    // 光标右边字符串
    String rightText = textEditingController.text
        .substring(index, textEditingController.text.length);
    textEditingController.text = "$leftText${emojiItem.emojiName}$rightText";

    int cursorIndex = index + "${emojiItem.emojiName}".length;
    // 设置光标位置
    textEditingController.selection =
        TextSelection(baseOffset: cursorIndex, extentOffset: cursorIndex);
  }

  // 点击+更多相应的操作
  void onMorePressed(CommMoreOption commMoreOption) {
    CommEventBusModel eventBusModel = CommEventBusModel(
      commEventBusType: CommEventBusType.commEventBusTypeMoreOption,
      data: commMoreOption,
    );
    kCommEventBus.fire(eventBusModel);
  }

  // 删除
  void onTextFieldDelete() {
    if (textEditingController.text.isEmpty) return;
    int index = textEditingController.selection.baseOffset;

    if (index > 0) {
      String leftText = textEditingController.text.substring(0, index - 1);
      String rightText = textEditingController.text
          .substring(index, textEditingController.text.length);
      textEditingController.text = "$leftText$rightText";

      int cursorIndex = index - 1;
      // 设置光标位置
      textEditingController.selection =
          TextSelection(baseOffset: index - 1, extentOffset: cursorIndex);
    }
  }

  // 发送消息
  void onTextFieldSend() {
    // 发送文本消息
    print("onTextFieldSend");
    if (textEditingController.text.isEmpty) return;

    String text = textEditingController.text;
    // 发送消息
    CommEventBusModel eventBusModel = CommEventBusModel(
      commEventBusType: CommEventBusType.commEventBusTypeSendText,
      data: text,
    );
    kCommEventBus.fire(eventBusModel);

    // 置空输入框文本
    textEditingController.text = "";
    // 设置光标位置
    int aLength = textEditingController.text.length;
    textEditingController.selection =
        TextSelection(baseOffset: aLength, extentOffset: aLength);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (event) {
        print("Listener onPointerDown:$event");
      },
      onPointerMove: (event) {
        print("Listener onPointerMove:$event");
      },
      onPointerUp: (event) {
        print("Listener onPointerUp:$event");
      },
      onPointerCancel: (event) {
        print("Listener onPointerCancel:$event");
        onEmojiLongCancel(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChatInputTextFieldBar(
              key: chatInputTextFieldBarKey,
              onEmojiButtonPressed: () {
                onEmojiButtonPressed();
              },
              onOutEmojiButtonPressed: () {
                onOutEmojiButtonPressed();
              },
              onInputFieldPressed: () {
                onInputFieldPressed();
              },
              onMoreButtonPressed: () {
                onMoreButtonPressed();
              },
              onInputOnEditingCompleted: () {
                onInputOnEditingCompleted();
              },
              chatInputBarController: widget.chatInputBarController,
              onPostButtonPressed: () {
                onPostButtonPressed();
              },
              textEditingController: textEditingController,
              inputOnSubmitted: (String text) {
                inputOnSubmitted(text);
              },
              onOutMoreButtonPressed: () {
                onOutMoreButtonPressed();
              },
              showPostEnterButton: widget.showPostEnterButton,
            ),
            buildSafeAreaBottom(context),
          ],
        ),
      ),
    );
  }

  Widget buildSafeAreaBottom(BuildContext context) {
    return ChatInputBottomPanel(
      key: inputBarBottomAreaKey,
      chatInputBarController: widget.chatInputBarController,
      onEmojiLongPressed:
          (CommonChatEmojiItem emojiItem, Offset? globalPosition) {
        onEmojiLongPressed(
          context,
          emojiItem: emojiItem,
          globalPosition: globalPosition,
        );
      },
      onMorePressed: (CommMoreOption moreOption) {
        onMorePressed(moreOption);
      },
      onTextFieldSend: () {
        onTextFieldSend();
      },
      onEmojiTapPressed: (CommonChatEmojiItem emojiItem) {
        onEmojiTapPressed(emojiItem);
      },
      onTextFieldDelete: () {
        onTextFieldDelete();
      },
      moreOptionEntries: widget.moreOptionEntries,
      chatInputTextFieldBarKey: chatInputTextFieldBarKey,
    );
  }
}
