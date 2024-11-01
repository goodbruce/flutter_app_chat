import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_emoji.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_more_option.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_emoji_panel.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_more_option_panel.dart';
import 'dart:io';

// 底部panel
class ChatInputBottomPanel extends StatefulWidget {
  const ChatInputBottomPanel({
    Key? key,
    required this.chatInputBarController,
    required this.onTextFieldDelete,
    required this.onEmojiTapPressed,
    required this.onEmojiLongPressed,
    required this.onMorePressed,
    required this.onTextFieldSend,
    required this.moreOptionEntries,
    required this.chatInputTextFieldBarKey,
  }) : super(key: key);

  final ChatInputBarController chatInputBarController;
  final Function onTextFieldDelete;
  final Function onTextFieldSend;
  final Function(CommonChatEmojiItem emojiItem) onEmojiTapPressed;
  final Function(CommonChatEmojiItem emojiItem, Offset? globalPosition)
      onEmojiLongPressed;
  final Function(CommMoreOption moreOption) onMorePressed;
  final List<CommMoreOption> moreOptionEntries;
  final GlobalKey chatInputTextFieldBarKey;

  @override
  State<ChatInputBottomPanel> createState() => _ChatInputBottomPanelState();
}

class _ChatInputBottomPanelState extends State<ChatInputBottomPanel>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey emojiPanelKey = GlobalKey();
  final GlobalKey morePanelKey = GlobalKey();
  final GlobalKey bottomKeyboardAreaKey = GlobalKey();
  final GlobalKey bottomIdleAreaKey = GlobalKey();

  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  // 默认
  ChatInputBarShowType inputBarShowType = ChatInputBarShowType.inputBarShowIdle;
  ChatInputBarShowType? preInputBarShowType;

  // 记录键盘的最大值
  double showKeyboardMaxHeight = 0.0;

  // 显示键盘高度
  double showKeyboardHeight = 0.0;

  // 开始的点
  double fromHeight = 0.0;

  // 结束的点
  double toHeight = 0.0;

  // 结束的点
  double viewPaddingBottom = 0.0;

  // 是否在动画过程中
  bool isKeyboardDismissAnimating = false;

  // 是否在动画过程中
  bool isAtAnimating = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    initAnimation();

    // 显示的状态类型
    widget.chatInputBarController.updateInputBarType =
        (ChatInputBarShowType oldShowType, ChatInputBarShowType newShowType) {
      inputBarShowType = newShowType;
      preInputBarShowType = oldShowType;
      print("updateInputBarType"
          "inputBarShowType:${inputBarShowType}, "
          "preInputBarShowType:${preInputBarShowType}");
      checkDismissPanelGesture();
    };

    // 动画
    widget.chatInputBarController.startBottomPanelAnimation = () {
      startAnimation();
    };
  }

  // 是否需要隐藏表情键盘手势
  void checkDismissPanelGesture() {
    bool isNeedDismissPanelGesture = false;
    if (ChatInputBarShowType.inputBarShowKeyboard == inputBarShowType ||
        ChatInputBarShowType.inputBarShowMore == inputBarShowType ||
        ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
      isNeedDismissPanelGesture = true;
      isAtAnimating = false;
    }

    print(
        "checkDismissPanelGesture isKeyboardDismissAnimating:${isKeyboardDismissAnimating}");

    if (widget.chatInputBarController.chatContainerNeedDismissPanelGesture !=
        null) {
      widget.chatInputBarController
          .chatContainerNeedDismissPanelGesture!(isNeedDismissPanelGesture);
    }
  }

  // 初始化动画
  void initAnimation() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _heightAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linear);
    _heightAnimation = Tween(
      begin: fromHeight,
      end: toHeight,
    ).animate(_heightAnimation);

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (ChatInputBarShowType.inputBarShowIdle == inputBarShowType) {
          showKeyboardMaxHeight = viewPaddingBottom;
        } else if (ChatInputBarShowType.inputBarShowKeyboard ==
            inputBarShowType) {
          showKeyboardMaxHeight = showKeyboardHeight;
        } else if (ChatInputBarShowType.inputBarShowMore == inputBarShowType) {
          showKeyboardMaxHeight = kMorePanelHeight;
        } else if (ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
          showKeyboardMaxHeight = kEmojiPanelHeight;
        } else if (ChatInputBarShowType.inputBarShowRecordAudio ==
            inputBarShowType) {
          showKeyboardMaxHeight = viewPaddingBottom;
        }

        isAtAnimating = false;
        isKeyboardDismissAnimating = false;
      }
    });
  }

  void startAnimation() {
    if (isAtAnimating) {
      return;
    }

    isAtAnimating = true;
    if (ChatInputBarShowType.inputBarShowIdle == preInputBarShowType) {
      fromHeight = viewPaddingBottom;
    } else if (ChatInputBarShowType.inputBarShowKeyboard ==
        preInputBarShowType) {
      fromHeight = showKeyboardMaxHeight;
    } else if (ChatInputBarShowType.inputBarShowMore == preInputBarShowType) {
      fromHeight = kMorePanelHeight;
    } else if (ChatInputBarShowType.inputBarShowEmoji == preInputBarShowType) {
      fromHeight = kEmojiPanelHeight;
    } else if (ChatInputBarShowType.inputBarShowRecordAudio ==
        preInputBarShowType) {
      fromHeight = viewPaddingBottom;
    }

    if (ChatInputBarShowType.inputBarShowIdle == inputBarShowType) {
      toHeight = viewPaddingBottom;
    } else if (ChatInputBarShowType.inputBarShowKeyboard == inputBarShowType) {
      toHeight = showKeyboardMaxHeight;
    } else if (ChatInputBarShowType.inputBarShowMore == inputBarShowType) {
      toHeight = kMorePanelHeight;
    } else if (ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
      toHeight = kEmojiPanelHeight;
    } else if (ChatInputBarShowType.inputBarShowRecordAudio ==
        inputBarShowType) {
      toHeight = viewPaddingBottom;
    }

    print("startAnimation "
        "from:${fromHeight}, "
        "to:${toHeight}, "
        "showKeyboardMaxHeight：${showKeyboardMaxHeight}"
        "showKeyboardHeight：${showKeyboardHeight}"
        "inputBarShowType：${inputBarShowType}");
    initAnimation();
    _controller.forward();
  }

  void animationDispose() {
    _controller.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    animationDispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (Platform.isAndroid) {
      if (widget.chatInputTextFieldBarKey.currentContext == null) return;
      // 获取输入框的位置
      final renderObject = widget.chatInputTextFieldBarKey.currentContext!
          .findRenderObject() as RenderBox;
      if (renderObject == null) return;

      // offset.dx , offset.dy 就是控件的左上角坐标
      Offset offset = renderObject.localToGlobal(Offset.zero);
      //获取size
      Size size = renderObject.size;

      double viewInsetsBottom = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio,
      ).bottom;
      print("didChangeMetrics "
          "viewInsetsBottom:${viewInsetsBottom}, "
          "inputBarShowType:${inputBarShowType},"
          "preInputBarShowType:${preInputBarShowType},"
          "showKeyboardHeight:${showKeyboardHeight},"
          "showKeyboardMaxHeight:${showKeyboardMaxHeight},"
          "offset:${offset}, "
          "size:${size},"
          "isKeyboardDismissAnimating:${isKeyboardDismissAnimating}");

      if (viewInsetsBottom == 0.0 &&
          ChatInputBarShowType.inputBarShowKeyboard == inputBarShowType &&
          showKeyboardHeight > 0.0 &&
          isKeyboardDismissAnimating == false &&
          isAtAnimating == false) {
        isKeyboardDismissAnimating = true;
        // 隐藏键盘键盘或者表情键盘弹出
        print("didChangeMetrics dismissChatInputPanel");
        if (widget.chatInputBarController.dismissChatInputPanel != null) {
          widget.chatInputBarController.dismissChatInputPanel!();
        }
      }
    }

    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    double viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

    if (showKeyboardMaxHeight < viewInsetsBottom) {
      showKeyboardMaxHeight = viewInsetsBottom;
    }

    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    viewPaddingBottom = viewPadding.bottom;
    Size screenSize = MediaQuery.of(context).size;
    // 表情
    if (ChatInputBarShowType.inputBarShowMore == inputBarShowType) {
      return Container(
        key: morePanelKey,
        width: screenSize.width,
        height: _heightAnimation.value,
        color: ColorUtil.hexColor(0xf7f7f7),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0.0,
              child: ChatMoreOptionPanel(
                morePanelHeight: kMorePanelHeight,
                chatInputBarController: widget.chatInputBarController,
                moreOptionEntries: widget.moreOptionEntries,
              ),
            ),
          ],
        ),
      );
    }

    // emoji
    if (ChatInputBarShowType.inputBarShowEmoji == inputBarShowType) {
      return Container(
        key: emojiPanelKey,
        width: screenSize.width,
        height: _heightAnimation.value,
        color: ColorUtil.hexColor(0xf7f7f7),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0.0,
              child: ChatInputEmojiPanel(
                emojiPanelHeight: kEmojiPanelHeight,
                chatInputBarController: widget.chatInputBarController,
                onTextFieldDelete: widget.onTextFieldDelete,
                onTextFieldSend: widget.onTextFieldSend,
                onEmojiTapPressed: widget.onEmojiTapPressed,
                onEmojiLongPressed: widget.onEmojiLongPressed,
              ),
            ),
          ],
        ),
      );
    }

    double bottomAreaHeight = viewPadding.bottom;
    showKeyboardHeight = viewInsetsBottom;

    if (bottomAreaHeight < showKeyboardHeight) {
      bottomAreaHeight = showKeyboardHeight;
    }

    print("build inputBarShowType:${inputBarShowType},"
        "_heightAnimation.value:${_heightAnimation.value},"
        "bottomAreaHeight:${bottomAreaHeight},"
        "viewPaddingBottom:${viewPaddingBottom}");

    if (ChatInputBarShowType.inputBarShowKeyboard == inputBarShowType) {
      return Container(
        key: bottomKeyboardAreaKey,
        decoration: BoxDecoration(
          color: ColorUtil.hexColor(0xf7f7f7),
        ),
        height: max(_heightAnimation.value, bottomAreaHeight),
        width: screenSize.width,
      );
    }

    if ((ChatInputBarShowType.inputBarShowEmoji == preInputBarShowType ||
        ChatInputBarShowType.inputBarShowMore == preInputBarShowType) &&
        ChatInputBarShowType.inputBarShowIdle == inputBarShowType) {
      // 键盘
      return Container(
        key: bottomIdleAreaKey,
        decoration: BoxDecoration(
          color: ColorUtil.hexColor(0xf7f7f7),
        ),
        height: max(_heightAnimation.value, bottomAreaHeight),
        width: screenSize.width,
      );
    }

    // 键盘
    return Container(
      key: bottomIdleAreaKey,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
      ),
      height: max(_heightAnimation.value, viewPadding.bottom),
      width: screenSize.width,
    );
  }
}
