import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chat/config/resource_manager.dart';
import 'package:flutter_app_chat/utils/color_util.dart';
import 'package:flutter_app_chat/widget/base_widget/button_widget.dart';
import 'package:flutter_app_chat/widget/chat_widget/comm_chat_emoji.dart';
import 'package:flutter_app_chat/widget/chat_widget/keyboard/chat_input_bar_controller.dart';

// 表情输入
class ChatInputEmojiPanel extends StatefulWidget {
  const ChatInputEmojiPanel({
    Key? key,
    required this.emojiPanelHeight,
    required this.chatInputBarController,
    required this.onTextFieldDelete,
    required this.onEmojiTapPressed,
    required this.onEmojiLongPressed,
    required this.onTextFieldSend,
  }) : super(key: key);

  final double emojiPanelHeight;
  final ChatInputBarController chatInputBarController;
  final Function onTextFieldDelete;
  final Function onTextFieldSend;
  final Function(CommonChatEmojiItem emojiItem) onEmojiTapPressed;
  final Function(CommonChatEmojiItem emojiItem, Offset globalPosition) onEmojiLongPressed;

  @override
  State<ChatInputEmojiPanel> createState() => _ChatInputEmojiPanelState();
}

class _ChatInputEmojiPanelState extends State<ChatInputEmojiPanel> {
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
    Size screenSize = MediaQuery.of(context).size;
    int crossAxisCount = 7;
    double itemSize = screenSize.width / crossAxisCount;
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;

    double emojiCateBarHeight = 50.0 + viewPadding.bottom;
    double deleteBarHeight = 50.0;

    return Container(
      width: screenSize.width,
      height: widget.emojiPanelHeight,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, //每行三列
                    childAspectRatio: 1.0, //显示区域宽高相等
                  ),
                  itemCount: CommonChatEmoji.emojiUrlList().length,
                  itemBuilder: (context, index) {
                    CommonChatEmojiItem emojiItem =
                        CommonChatEmoji.emojiUrlList()[index];
                    return ChatInputEmojiButton(
                      emojiItem: emojiItem,
                      size: itemSize,
                      onEmojiLongPressed: widget.onEmojiLongPressed,
                      onEmojiTapPressed: widget.onEmojiTapPressed,
                    );
                  },
                  padding: EdgeInsets.only(
                    bottom: deleteBarHeight,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: ChatInputEmojiDeleteBar(
                    height: deleteBarHeight,
                    onTextFieldDelete: widget.onTextFieldDelete,
                  ),
                ),
              ],
            ),
          ),
          ChatInputEmojiCateBar(
            height: emojiCateBarHeight,
            onTextFieldSend: widget.onTextFieldSend,
          ),
        ],
      ),
    );
  }
}

// 显示表情Emoji图片
class ChatInputEmojiButton extends StatelessWidget {
  const ChatInputEmojiButton({
    Key? key,
    required this.emojiItem,
    required this.size,
    required this.onEmojiTapPressed,
    required this.onEmojiLongPressed,
  }) : super(key: key);

  final CommonChatEmojiItem emojiItem;
  final double size;
  final Function(CommonChatEmojiItem emojiItem) onEmojiTapPressed;
  final Function(CommonChatEmojiItem emojiItem, Offset globalPosition) onEmojiLongPressed;

  @override
  Widget build(BuildContext context) {
    double iconSize = size;
    if (iconSize > 36.0) {
      iconSize = 36.0;
    }
    return ButtonWidget(
      width: size,
      height: size,
      onLongPressStart: (LongPressStartDetails details) {
        onEmojiLongPressed(emojiItem, details.globalPosition);
      },
      onPressed: () {
        onEmojiTapPressed(emojiItem);
      },
      child: ImageHelper.imageNetwork(
        imageUrl: "${emojiItem.url}",
        fit: BoxFit.cover,
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}

// 表情键盘底部发送及删除按钮
class ChatInputEmojiDeleteBar extends StatefulWidget {
  const ChatInputEmojiDeleteBar({
    Key? key,
    required this.height,
    required this.onTextFieldDelete,
  }) : super(key: key);

  final double height;
  final Function onTextFieldDelete;

  @override
  State<ChatInputEmojiDeleteBar> createState() =>
      _ChatInputEmojiDeleteBarState();
}

class _ChatInputEmojiDeleteBarState extends State<ChatInputEmojiDeleteBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      color: Colors.transparent,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonWidget(
            onPressed: () {
              widget.onTextFieldDelete();
            },
            child: ImageHelper.wrapAssetAtImages(
              "icons/ic_backspace.png",
              fit: BoxFit.cover,
              width: 42.0,
              height: 42.0,
            ),
          ),
        ],
      ),
    );
  }
}

// 底部表情切换bar
class ChatInputEmojiCateBar extends StatefulWidget {
  const ChatInputEmojiCateBar({
    Key? key,
    required this.height,
    required this.onTextFieldSend,
  }) : super(key: key);

  final double height;
  final Function onTextFieldSend;

  @override
  State<ChatInputEmojiCateBar> createState() => _ChatInputEmojiCateBarState();
}

class _ChatInputEmojiCateBarState extends State<ChatInputEmojiCateBar> {
  @override
  Widget build(BuildContext context) {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    Size screenSize = MediaQuery.of(context).size;

    print("ChatInputEmojiCateBar viewPadding bottom：${viewPadding.bottom}");
    return Container(
      width: screenSize.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: ColorUtil.hexColor(0xf7f7f7),
        border: Border(
          bottom: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          left: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          right: BorderSide(width: 0.0, color: ColorUtil.hexColor(0xffffff)),
          top: BorderSide(width: 1.0, color: ColorUtil.hexColor(0xf0f0f0)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonWidget(
                  margin: EdgeInsets.only(left: 10.0),
                  width: 36.0,
                  onPressed: () {},
                  child: ImageHelper.wrapAssetAtImages(
                    "icons/ic_custom_emoji_cate.png",
                    fit: BoxFit.cover,
                    width: 32.0,
                    height: 32.0,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                ButtonWidget(
                  margin: const EdgeInsets.only(left: 10.0),
                  width: 70.0,
                  bgColor: ColorUtil.hexColor(0xf7f7f7),
                  bgHighlightedColor: ColorUtil.hexColor(0x3b93ff, alpha: 0.35),
                  onPressed: () {
                    widget.onTextFieldSend();
                  },
                  child: Text(
                    "发送",
                    textAlign: TextAlign.center,
                    maxLines: 1000,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: ColorUtil.hexColor(0x3b93ff),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: viewPadding.bottom,
          ),
        ],
      ),
    );
  }
}
